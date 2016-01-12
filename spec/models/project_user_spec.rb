require File.dirname(__FILE__) + '/../spec_helper.rb'

describe ProjectUser, "creation" do
  it "should subscribe user to assessment sections if curator" do
    as = AssessmentSection.make!
    p = as.assessment.project
    pu = without_delay do
      ProjectUser.make!(:project => p, :role => ProjectUser::CURATOR)
    end
    pu.user.subscriptions.where(:resource_type => "AssessmentSection", :resource_id => as).should_not be_blank
  end

  it "should subscribe user to assessment sections if manager" do
    as = AssessmentSection.make!
    p = as.assessment.project
    pu = without_delay do
      ProjectUser.make!(:project => p, :role => ProjectUser::MANAGER)
    end
    pu.user.subscriptions.where(:resource_type => "AssessmentSection", :resource_id => as).should_not be_blank
  end

  it "should not subscribe user to assessment sections if role blank" do
    as = AssessmentSection.make!
    p = as.assessment.project
    pu = without_delay do
      ProjectUser.make!(:project => p)
    end
    pu.user.subscriptions.where(:resource_type => "AssessmentSection", :resource_id => as).should be_blank
  end

  describe "invite-only projects" do
    let(:project) { Project.make!(:prefers_membership_model => Project::MEMBERSHIP_INVITE_ONLY) }
    
    it "should not be valid for invite-only projects without a project user invitation" do
      pu = ProjectUser.make(:project => project)
      pu.should_not be_valid
    end

    it "should be valid for invite-only projects with a project user invitation" do
      pui = ProjectUserInvitation.make!(:project => project)
      pu = ProjectUser.make!(:project => project, :user => pui.invited_user)
      pu.should be_valid
    end
  end
end

describe ProjectUser do
  describe "update_taxa_counter_cache" do
    it "should set taxa_count to the number of observed species" do
      project_user = ProjectUser.make!
      taxon = Taxon.make!(:rank => "species")
      lambda {
        project_observation = ProjectObservation.make!(
          :observation => Observation.make!(:user => project_user.user, :taxon => taxon), 
          :project => project_user.project)
        project_user.update_taxa_counter_cache
        project_user.reload
      }.should change(project_user, :taxa_count).by(1)
    end

    it "should set taxa_count to number of species observed OR identified by a curator" do
      t = Taxon.make!(:rank => Taxon::SPECIES)
      po = make_project_observation
      pu = po.project.project_users.where(:user_id => po.observation.user_id).first
      pu.taxa_count.should eq 0
      puc = ProjectUser.make!(:project => po.project, :role => ProjectUser::CURATOR)
      i = without_delay do
        Identification.make!(:observation => po.observation, :user => puc.user, :taxon => t)
      end
      po.reload
      po.curator_identification.should_not be_blank
      pu.update_taxa_counter_cache
      pu.reload
      pu.taxa_count.should eq 1
    end
  end
  
  describe "update_observations_counter_cache" do
    it "should set observations_count to the number of observed species" do
      project_user = ProjectUser.make!
      taxon = Taxon.make!(:rank => "species")
      lambda {
        project_observation = ProjectObservation.make!(
          :observation => Observation.make!(:user => project_user.user, :taxon => taxon), 
          :project => project_user.project)
        project_user.update_observations_counter_cache
        project_user.reload
      }.should change(project_user, :observations_count).by(1)
    end
  end
  
  describe "updating role" do
    before(:each) do
      @project_user = ProjectUser.make!
      Delayed::Job.delete_all
      @now = Time.now
    end
    
    it "should queue a job to update identifications if became curator" do
      @project_user.update_attributes(:role => ProjectUser::CURATOR)
      jobs = Delayed::Job.all(:conditions => ["created_at >= ?", @now])
      jobs.select{|j| j.handler =~ /Project.*update_curator_idents_on_make_curator/m}.should_not be_blank
    end
    
    it "should queue a job to update identifications if became manager" do
      @project_user.update_attributes(:role => ProjectUser::MANAGER)
      jobs = Delayed::Job.all(:conditions => ["created_at >= ?", @now])
      jobs.select{|j| j.handler =~ /Project.*update_curator_idents_on_make_curator/m}.should_not be_blank
    end
    
    it "should queue a job to update identifications if no longer curator" do
      @project_user.update_attributes(:role => ProjectUser::CURATOR)
      Delayed::Job.delete_all
      @project_user.update_attributes(:role => nil)
      jobs = Delayed::Job.all(:conditions => ["created_at >= ?", @now])
      jobs.select{|j| j.handler =~ /Project.*update_curator_idents_on_remove_curator/m}.should_not be_blank
    end
    
    it "should not queue a job to update identifications if moving btwn manager and curator" do
      @project_user.update_attributes(:role => ProjectUser::CURATOR)
      Delayed::Job.delete_all
      @project_user.update_attributes(:role => ProjectUser::MANAGER)
      jobs = Delayed::Job.all(:conditions => ["created_at >= ?", @now])
      jobs.select{|j| j.handler =~ /Project.*update_curator_idents_on_remove_curator/m}.should be_blank
      jobs.select{|j| j.handler =~ /Project.*update_curator_idents_on_make_curator/m}.should be_blank
    end

    it "should notify project members of new curators" do
      pu = ProjectUser.make!
      start = Time.now
      curator_pu = without_delay do 
        ProjectUser.make!(:project => pu.project, :role => ProjectUser::CURATOR)
      end
      u = Update.where("created_at >= ?", start).where(:subscriber_id => pu.user_id).first
      u.should_not be_blank
    end

    it "should notify project members of new managers" do
      pu = ProjectUser.make!
      start = Time.now
      curator_pu = without_delay do 
        ProjectUser.make!(:project => pu.project, :role => ProjectUser::MANAGER)
      end
      u = Update.where("created_at >= ?", start).where(:subscriber_id => pu.user_id).first
      u.should_not be_blank
    end

    it "should notify project members of new owners" do
      pu = ProjectUser.make!
      p = pu.project
      new_pu = ProjectUser.make!(:project => p)
      start = Time.now
      without_delay do
        p.update_attributes(:user => new_pu.user)
      end
      u = Update.where("created_at >= ?", start).where(:subscriber_id => pu.user_id).first
      u.should_not be_blank
    end
  end
end
