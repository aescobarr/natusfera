require File.dirname(__FILE__) + '/../spec_helper'

describe ObservationsController do
  describe :create do
    let(:user) { User.make! }
    before do
      sign_in user
    end
    it "should not raise an exception if the obs was invalid and an image was submitted"
    
    it "should not raise an exception if no observations passed" do
      lambda {
        post :create
      }.should_not raise_error
    end
    
    it "should add project observations if auto join project specified" do
      project = Project.make!
      project.users.find_by_id(user.id).should be_blank
      post :create, :observation => {:species_guess => "Foo!"}, :project_id => project.id, :accept_terms => true
      project.users.find_by_id(user.id).should_not be_blank
      project.observations.last.id.should == Observation.last.id
    end
    
    it "should add project observations if auto join project specified and format is json" do
      project = Project.make!
      project.users.find_by_id(user.id).should be_blank
      post :create, :format => "json", :observation => {:species_guess => "Foo!"}, :project_id => project.id
      project.users.find_by_id(user.id).should_not be_blank
      project.observations.last.id.should == Observation.last.id
    end
    
    it "should set taxon from taxon_name param" do
      taxon = Taxon.make!
      post :create, :observation => {:species_guess => "Foo", :taxon_name => taxon.name}
      obs = user.observations.last
      obs.should_not be_blank
      obs.taxon_id.should == taxon.id
      obs.species_guess.should == "Foo"
    end
    
    it "should set the site" do
      # @site = Site.make!
      class InatConfig
        def site_id
          @site ||= Site.make!
          @site.id
        end
      end
      post :create, :observation => {:species_guess => "Foo"}
      user.observations.last.site.should_not be_blank
    end
  end
  
  describe :update do
    it "should not raise an exception if no observations passed" do
      user = User.make!
      sign_in user
      
      lambda {
        post :update
      }.should_not raise_error
    end
    
    it "should use latitude param even if private_latitude set" do
      taxon = Taxon.make!(:conservation_status => Taxon::IUCN_ENDANGERED, :rank => "species")
      observation = Observation.make!(:taxon => taxon, :latitude => 38, :longitude => -122)
      observation.private_longitude.should_not be_blank
      old_latitude = observation.latitude
      old_private_latitude = observation.private_latitude
      sign_in observation.user
      post :update, :id => observation.id, :observation => {:latitude => 1}
      observation.reload
      observation.private_longitude.should_not be_blank
      observation.latitude.to_f.should_not == old_latitude.to_f
      observation.private_latitude.to_f.should_not == old_private_latitude.to_f
    end
  end
  
  describe :import_photos do
    # to test this we need to mock a flickr response
    it "should import photos that are already entered as taxon photos"
  end

  describe :by_login_all, "page cache" do
    before do
      @observation = Observation.make!
      @user = @observation.user
      path = observations_by_login_all_path(@user.login, :format => 'csv')
      FileUtils.rm private_page_cache_path(path), :force => true
      sign_in @user
    end

    it "should set after request" do
      without_delay do
        get :by_login_all, :login => @user.login, :format => :csv
      end
      response.should be_private_page_cached
    end

    it "should be cleared by new observations" do
      without_delay do
        get :by_login_all, :login => @user.login, :format => :csv
      end
      response.should be_private_page_cached
      post :create, :observation => {:species_guess => "foo"}
      observations_by_login_all_path(@user.login, :format => :csv).should_not be_private_page_cached
    end
  end

  describe :project do
    render_views
    it "should include private coordinates when viewed by a project curator" do
      po = make_project_observation
      o = po.observation
      log_timer do
        o.update_attributes(:geoprivacy => Observation::PRIVATE, :latitude => 1.23456, :longitude => 1.23456)
      end
      o.reload
      o.private_latitude.should_not be_blank
      p = po.project
      pu = ProjectUser.make!(:project => p, :role => ProjectUser::CURATOR)
      u = pu.user
      sign_in u
      get :project, :id => p.id
      response.body.should =~ /#{o.private_latitude}/
    end

    it "should not include private coordinates when viewed by a project curator" do
      po = make_project_observation
      o = po.observation
      o.update_attributes(:geoprivacy => Observation::PRIVATE, :latitude => 1.23456, :longitude => 1.23456)
      o.reload
      o.private_latitude.should_not be_blank
      p = po.project
      pu = ProjectUser.make!(:project => p)
      u = pu.user
      sign_in u
      get :project, :id => p.id
      response.body.should_not =~ /#{o.private_latitude}/
    end
  end

  describe :project_all, "page cache" do
    before do
      @project = Project.make!
      @user = @project.user
      @observation = Observation.make!(:user => @user)
      @project_observation = make_project_observation(:project => @project, :observation => @observation)
      @observation = @project_observation.observation
      ActionController::Base.perform_caching = true
      path = all_project_observations_path(@project, :format => 'csv')
      FileUtils.rm private_page_cache_path(path), :force => true
      sign_in @user
    end

    after do
      ActionController::Base.perform_caching = false
    end

    it "should set after request" do
      without_delay do
        get :project_all, :id => @project, :format => :csv
      end
      response.should be_private_page_cached
    end

    it "should be cleared by new observations" do
      without_delay do
        get :project_all, :id => @project, :format => :csv
      end
      response.should be_private_page_cached
      post :destroy, :id => @observation
      all_project_observations_path(@project, :format => :csv).should_not be_private_page_cached
    end
  end

  describe :by_login_all do
    it "should include observation fields" do
      of = ObservationField.make!(:name => "count", :datatype => "numeric")
      ofv = ObservationFieldValue.make!(:observation_field => of, :value => 7)
      user = ofv.observation.user
      sign_in user
      get :by_login_all, :login => user.login, :format => :csv
      response.body.should =~ /field\:count/
    end
  end

  describe :project_all, "csv" do
    it "should include observation fields" do
      of = ObservationField.make!(:name => "count", :datatype => "numeric")
      pof = ProjectObservationField.make!(:observation_field => of)
      p = pof.project
      po = make_project_observation(:project => p)
      ofv = ObservationFieldValue.make!(:observation_field => of, :value => 7, :observation => po.observation)
      sign_in p.user
      get :project_all, :id => p.id, :format => :csv
      response.body.should =~ /field\:count/
    end

    it "should have project-specific fields" do
      p = Project.make!
      sign_in p.user
      get :project_all, :id => p.id, :format => :csv
      %w(curator_ident_taxon_id curator_ident_taxon_name curator_ident_user_id curator_ident_user_login tracking_code).each do |f|
        response.body.should =~ /#{f}/
      end
    end
  end
  
  describe :photo do
    let(:file) { fixture_file_upload('files/egg.jpg', 'image/jpeg') }
    before do
      @user = User.make!
      sign_in @user
    end
    it "should generate an error if no files specified" do
      post :photo, :format => :json
      json = JSON.parse(response.body)
      json['error'].should_not be_blank
    end

    it "should set the site based on config" do
      class InatConfig
        def site_id
          @site = Site.make!
          @site.id
        end
      end
      post :photo, :format => :json, :files => [ file ]
      @user.observations.last.site.should_not be_blank
    end

    it "should set the site based on user's site" do
      @user.update_attribute(:site_id, Site.make!.id)
      post :photo, :format => :json, :files => [ file ]
      @user.observations.last.site.should_not be_blank
    end

    # ugh, how to test uploads...
    it "should generate an error if single file makes invalid photo"
  end
end

describe ObservationsController, "spam" do
  let(:spammer_content) { Observation.make!(user: User.make!(spammer: true)) }
  let(:flagged_content) {
    o = Observation.make!
    Flag.make!(flaggable: o, flag: Flag::SPAM)
    o
  }

  it "should render 403 when the owner is a spammer" do
    get :show, id: spammer_content.id
    response.response_code.should == 403
  end

  it "should render 403 when content is flagged as spam" do
    get :show, id: spammer_content.id
    response.response_code.should == 403
  end
end
