require 'spec_helper'

describe User do
  let(:user) { User.create(:twitter_username => "jkoszewski", :twitter_link => "https://twitter.com/#!/jkoszewski") }

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

  describe "#find_klout_score" do

    it "returns an integer" do
      user.find_klout_score.class.should == Fixnum
    end

    it "returns a klout score for a particular user" do
      user.find_klout_score.should == 41
    end
  end

  describe "#set_klout_score" do

    it "sets a user's klout score to the found klout score" do
      user.set_klout_score
      user.klout_score.should == 41
    end

  end
end