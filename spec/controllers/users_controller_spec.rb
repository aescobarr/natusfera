require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController, "dashboard" do
  it "should be accessible when signed in" do
    user = User.make!
    sign_in user
    get :dashboard
    response.should be_success
  end
end

describe UsersController, "delete" do
  it "should be possible for the user" do
    user = User.make!
    sign_in user
    without_delay { delete :destroy, :id => user.id }
    response.should be_redirect
    User.find_by_id(user.id).should be_blank
  end
  
  it "should be impossible for everyone else" do
    user = User.make!
    nogoodnik = User.make!
    sign_in nogoodnik
    delete :destroy, :id => user.id
    User.find_by_id(user.id).should_not be_blank
  end
end

describe UsersController, "search" do
  it "should work while signed out" do
    get :search
    response.should be_success
  end
end

describe UsersController, "spam" do
  let(:spammer) { User.make!(spammer: true) }

  it "should render 403 when the user is a spammer" do
    get :show, id: spammer.id
    response.response_code.should == 403
  end
end
