class Update < ActiveRecord::Base
  belongs_to :subscriber, :class_name => "User"
  belongs_to :resource, :polymorphic => true
  belongs_to :notifier, :polymorphic => true
  belongs_to :resource_owner, :class_name => "User"
  
  validates_uniqueness_of :notifier_id, :scope => [:notifier_type, :subscriber_id, :notification]
  validates_presence_of :resource, :notifier, :subscriber
  
  before_create :set_resource_owner
  after_create :expire_caches
  
  NOTIFICATIONS = %w(create change activity)
  
  scope :unviewed, where("viewed_at IS NULL")
  scope :activity, where(:notification => "activity")
  scope :activity_on_my_stuff, where("resource_owner_id = subscriber_id AND notification = 'activity'")

  def to_s
    "<Update #{id} subscriber: #{subscriber_id} resource_type: #{resource_type} " +
      "resource_id: #{resource_id} notifier_type: #{notifier_type} notifier_id: #{notifier_id}>"
  end
  
  def set_resource_owner
    self.resource_owner = resource && resource.respond_to?(:user) ? resource.user : nil
  end
  
  def sort_by_date
    created_at || notifier.try(:created_at) || Time.now
  end
  
  def expire_caches
    ctrl = ActionController::Base.new
    ctrl.expire_fragment(FakeView.home_url(:user_id => subscriber_id).gsub('http://', ''))
    true
  end
  
  def self.load_additional_activity_updates(updates)
    # fetch all other activity updates for the loaded resources
    activity_updates = updates.select{|u| u.notification == 'activity'}
    return updates if activity_updates.blank?
    activity_update_ids = activity_updates.map{|u| u.id}
    clauses = []
    activity_updates.each do |update|
      clauses << "(subscriber_id = #{update.subscriber_id} AND resource_type = '#{update.resource_type}' AND resource_id = #{update.resource_id})"
    end
    conditions = ["notification = 'activity' AND id NOT IN (?)", activity_update_ids]
    conditions[0] += " AND (#{clauses.join(' OR ')})" unless clauses.blank?
    updates += Update.all(:conditions => conditions, :include => [:resource, :notifier, :subscriber, :resource_owner])
    updates
  end
  
  def self.group_and_sort(updates, options = {})
    grouped_updates = []
    update_cache = options[:update_cache]
    
    updates.group_by{|u| [u.resource_type, u.resource_id, u.notification]}.each do |key, batch|
      resource_type, resource_id, notification = key
      batch = batch.sort_by{|u| u.sort_by_date}
      if options[:hour_groups] && "created_observations new_observations".include?(notification.to_s) && batch.size > 1
        batch.group_by{|u| u.created_at.strftime("%Y-%m-%d %H")}.each do |hour, hour_updates|
          grouped_updates << [key, hour_updates]
        end
      elsif notification == "activity" && !options[:skip_past_activity]
        # get the resource that has all this activity
        resource = if update_cache && update_cache[resource_type.underscore.pluralize.to_sym]
          update_cache[resource_type.underscore.pluralize.to_sym][resource_id]
        end
        resource ||= Object.const_get(resource_type).find_by_id(resource_id)
        if resource.blank?
          Rails.logger.error "[ERROR #{Time.now}] couldn't find resource #{resource_type} #{resource_id}, first update: #{batch.first}"
          next
        end
        
        # get the associations on that resource that generate activity updates
        activity_assocs = resource.class.notifying_associations.select do |assoc, assoc_options|
          assoc_options[:notification] == "activity"
        end
        
        # create pseudo updates for all activity objects
        activity_assocs.each do |assoc, assoc_options|
          # this is going to lazy load assoc's of the associate (e.g. a comment's user) which might not be ideal
          resource.send(assoc).each do |associate|
            unless batch.detect{|u| u.notifier_type == associate.class.name && u.notifier_id == associate.id}
              batch << Update.new(:resource => resource, :notifier => associate, :notification => "activity")
            end
          end
        end
        grouped_updates << [key, batch.sort_by{|u| u.sort_by_date}]
      else
        grouped_updates << [key, batch]
      end
    end
    grouped_updates.sort_by {|key, updates| updates.last.sort_by_date.to_i * -1}
  end
  
  def self.email_updates
    start_time = 1.day.ago.utc
    end_time = Time.now.utc
    email_count = 0
    user_ids = Update.all(
        :select => "DISTINCT subscriber_id",
        :conditions => ["created_at BETWEEN ? AND ?", start_time, end_time]).map{|u| u.subscriber_id}.compact.uniq.sort
    delivery_times = []
    process_start_time = Time.now
    msg = "[INFO #{Time.now}] start daily updates emailer, #{user_ids.size} users"
    Rails.logger.info msg
    puts msg
    user_ids.each do |subscriber_id|
      delivery_start_time = Time.now
      msg =  "[INFO #{Time.now}] daily updates emailer: user #{subscriber_id}"
      Rails.logger.info msg
      puts msg
      email_sent = begin
        email_updates_to_user(subscriber_id, start_time, end_time)
      rescue Net::SMTPServerBusy => e
        sleep(5)
        begin
          email_updates_to_user(subscriber_id, start_time, end_time)
        rescue Net::SMTPServerBusy => e
          msg =  "[ERROR #{Time.now}] daily updates emailer couldn't deliver to #{subscriber_id} (Net::SMTPServerBusy): #{e.message}"
          Rails.logger.error msg
          puts msg
          next
        end
      end
      if email_sent
        msg =  "[INFO #{Time.now}] daily updates emailer: user #{subscriber_id} sent"
        Rails.logger.info msg
        puts msg
        delivery_times << (Time.now - delivery_start_time)
        email_count += 1
      end
    end
    avg_time = delivery_times.size == 0 ? 0 : delivery_times.sum / delivery_times.size
    msg = "[INFO #{Time.now}] end daily updates emailer, sent #{email_count} in #{Time.now - process_start_time} s, avg: #{avg_time}"
    Rails.logger.info msg
    puts msg
  end
  
  def self.email_updates_to_user(subscriber, start_time, end_time)
    user = subscriber
    user = User.find_by_id(subscriber.to_i) unless subscriber.is_a?(User)
    user ||= User.find_by_login(subscriber)
    return unless user.is_a?(User)
    return if user.email.blank?
    return if user.prefers_no_email
    return unless user.active? # email verified
    updates = Update.all(:limit => 100, :conditions => [
      "subscriber_id = ? AND created_at BETWEEN ? AND ?", user.id, start_time, end_time])
    updates.delete_if do |u| 
      !user.prefers_project_journal_post_email_notification? && u.resource_type == "Project" && u.notifier_type == "Post" ||
      !user.prefers_comment_email_notification? && u.notifier_type == "Comment" ||
      !user.prefers_identification_email_notification? && u.notifier_type == "Identification"
    end.compact
    return if updates.blank?
    Emailer.updates_notification(user, updates).deliver
    true
  end
  
  def self.eager_load_associates(updates, options = {})
    includes = options[:includes] || {
      :observation => [:user, {:taxon => :taxon_names}, :iconic_taxon, :photos],
      :observation_field => [:user],
      :identification => [:user, {:taxon => [:taxon_names, :photos]}, {:observation => :user}],
      :comment => [:user, :parent],
      :listed_taxon => [{:list => :user}, {:taxon => [:photos, :taxon_names]}],
      :taxon => [:taxon_names, {:taxon_photos => :photo}],
      :post => [:user, :parent],
      :flag => [:resolver],
      :project => [],
      :project_invitation => [:project, :user],
      :taxon_change => [:taxon, {:taxon_change_taxa => [:taxon]}, :user]
    }
    update_cache = {}
    klasses = [
      Comment, 
      Flag, 
      Identification, 
      ListedTaxon, 
      Observation, 
      ObservationField,
      Post, 
      Project, 
      ProjectInvitation, 
      Taxon,
      TaxonChange,
      User
    ]
    klasses += TaxonChange::TYPES.map{|t| Object.const_get(t) rescue nil}.compact
    klasses.each do |klass|
      ids = []
      updates.each do |u|
        ids << u.notifier_id if u.notifier_type == klass.to_s
        ids << u.resource_id if u.resource_type == klass.to_s
      end
      ids = ids.compact.uniq
      next if ids.blank?
      update_cache[klass.to_s.underscore.pluralize.to_sym] = klass.all(
        :conditions => ["id IN (?)", ids], 
        :include => includes[klass.to_s.underscore.to_sym]
      ).index_by{|o| o.id}
    end
    update_cache[:users] ||= {}
    updates.each do |update|
      update_cache[:users][update.subscriber_id] = update.subscriber
      update_cache[:users][update.resource_owner_id] = update.resource_owner if update.resource_owner
    end
    update_cache
  end
  
  def self.user_viewed_updates(updates)
    updates = updates.compact
    return if updates.blank?
    subscriber_id = updates.first.subscriber_id
    
    # mark all as viewed
    Update.update_all(["viewed_at = ?", Time.now], ["id in (?)", updates])
    
    # delete PAST activity updates that were not in this batch
    clauses = []
    update_ids = []
    updates.each do |update|
      next unless update.notification == 'activity'
      Update.delay(:priority => USER_INTEGRITY_PRIORITY).delete_all([
        "id < ? AND notification = 'activity' AND subscriber_id = ? AND resource_type = ? AND resource_id = ?", 
        update.id, update.subscriber_id, update.resource_type, update.resource_id
      ])
    end
    
    unless Delayed::Job.where("handler LIKE '%Update%sweep_for_user% #{subscriber_id}\n%'").exists?
      Update.delay(:priority => USER_INTEGRITY_PRIORITY, :queue => "slow", :run_at => 6.hours.from_now).sweep_for_user(subscriber_id)
    end
  end

  def self.sweep_for_user(user_id)
    return if user_id.blank?
    Update.delete_all(["subscriber_id = ? AND created_at < ?", user_id, 6.months.ago])
  end
end
