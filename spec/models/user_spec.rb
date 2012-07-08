require 'spec_helper'

describe User do
  let(:user) { User.create(:twitter_username => "hungryfeedme1") }
  let(:invalid_user) { User.create(:twitter_username => "hungrybotdoesnteatnow") }
  let(:omniauth_data) { {"provider" => "Twitter", "uid" => 1234, "credentials" => {"token" => "12345abcdefg", "secret" => "abcdefg12345"} } }

  it "has an ActiveModel mass assignment method for twitter_username" do
    expect { user.send(:twitter_username) }.to_not raise_error(NoMethodError)
  end

  it "has an ActiveModel mass assignment method for klout_score" do
    expect { user.send(:klout_score) }.to_not raise_error(NoMethodError)
  end

  it "has a find_klout_score method" do
    expect { user.send(:find_klout_score) }.to_not raise_error(NoMethodError)
  end

  it "has a set_klout_score method" do
    expect { user.send(:find_klout_score) }.to_not raise_error(NoMethodError)
  end

  it "has a set_twitter_link method" do
    expect { user.send(:set_twitter_link) }.to_not raise_error(NoMethodError)
  end

  describe "#find_klout_score" do

    context "when passed valid data" do
      it "returns an integer" do
        user.find_klout_score.class.should == Fixnum
      end

      it "returns a klout score for a particular user" do
        user.find_klout_score.should == 12
      end
    end

    context "when passed invalid data" do
      it "returns an integer" do
        invalid_user.find_klout_score.class.should == Fixnum
      end

      it "returns zero" do
        invalid_user.find_klout_score.should == 0
      end
    end
  end

  describe "#set_klout_score" do

    it "sets a user's klout score to the found klout score" do
      user.set_klout_score
      user.klout_score.should == 12
    end

  end

  describe "#set_twitter_link" do

    it "sets a user's twitter_link attribute" do
      user.set_twitter_link
      user.twitter_link.should == "https://twitter.com/hungryfeedme1"
    end

  end

  describe "#build_authentications" do

    context "when supplied with valid omniauth data" do

      it "creates a new Authentication object" do
        user.build_authentication(omniauth_data).should be_a_kind_of(Authentication)
      end

      context "when the user has been saved" do
        
        it "adds a new unique authentication to all Authentication objects" do
          expect { user.build_authentication(omniauth_data).save! }.to change{ Authentication.all.count }.by(1)
        end

        it "creates a new Authentication object for the user on which the method is called" do
          expect { user.build_authentication(omniauth_data).save! }.to change{ user.authentications.count }.by(1)
        end
      end
    end
  end
end