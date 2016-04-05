class WelcomeController < ApplicationController 

  MOBILIZED = [:index]
  before_filter :unmobilized, :except => MOBILIZED
  before_filter :mobilized, :only => MOBILIZED
  
  def index
    respond_to do |format|
      format.html do
        @announcement = Announcement.where('placement = \'welcome/index\' AND ? BETWEEN "start" AND "end"', Time.now.utc).last
        @observations_cache_key = "#{SITE_NAME}_#{I18n.locale}_welcome_observations"
        unless fragment_exist?(@observations_cache_key)
          if Rails.env.development?
            @observations = Observation.has_geo.has_photos
                                      .includes([ :taxon,
                                                  :stored_preferences,
                                                  { :observation_photos => :photo },
                                                  { :user => :stored_preferences } ])
                                      .limit(4)
                                      .order("observations.id DESC").scoped
          else
            @observations = Observation.find([395, 394, 393, 382])
          end
          #if CONFIG.site_only_observations && params[:site].blank?
          #  @observations = @observations.where("observations.uri LIKE ?", "#{FakeView.root_url}%")
          #elsif (site_bounds = CONFIG.bounds) && params[:swlat].blank?
          #  @observations = @observations.in_bounding_box(site_bounds['swlat'], site_bounds['swlng'], site_bounds['nelat'], site_bounds['nelng'])
          #end
        end
        @page = WikiPage.find_by_path(CONFIG.home_page_wiki_path) if CONFIG.home_page_wiki_path
        @google_webmaster_verification = @site.google_webmaster_verification if @site
        @sample_observations = Observation.has_photos.order("RANDOM()").limit(4)
        # begin
        #   @sample_observations = Observation.find([395, 394, 393, 382])
        # rescue ActiveRecord::RecordNotFound
        #   @sample_observations = Observation.has_photos.order("RANDOM()").limit(4)
        # end
        @sample_projects = Project.order("RANDOM()").limit(4)
        @sample_users = User.order("RANDOM()").limit(4)
      end
      format.mobile
    end
  end
  
  def toggle_mobile
    session[:mobile_view] = session[:mobile_view] ? false : true
    redirect_to params[:return_to] || session[:return_to] || "/"
  end

end
