require "spec_helper"

describe Rakismet, "ActiveRecord" do

  it "knows the spammable models" do
    Rakismet.spammable_models.should == [ Observation, Post, Comment,
      Identification, List, Project, Guide, GuideSection, LifeList ]
  end

  it "knows good fake_environment_variables" do
    Rakismet.fake_environment_variables.should == {
      "REMOTE_ADDR" => "127.0.0.1",
      "HTTP_USER_AGENT" =>
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 " +
        "(KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36"
    }
  end

  it "should disable API calls" do
    Rakismet.should_receive(:akismet_call).at_least(:once).and_return("true")
    @spam_user = User.make!(name: "viagra-test-123")
    # with Rakismet endabled, spam? gets called and a flag is made
    Rakismet.disabled = false
    o = make_spammy_observation
    o.flagged_as_spam?.should == true
    # with Rakismet disabled, spam? won't get called and thus no flag is made
    Rakismet.disabled = true
    o = make_spammy_observation
    o.flagged_as_spam?.should == false
  end

end

def make_spammy_observation
  Observation.make!(description: "anything")
end
