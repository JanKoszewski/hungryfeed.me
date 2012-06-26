require 'spec_helper'

describe Tweet do
  let(:tweet) { Tweet.create(:twitter_username => "hungryfeedme1", :twitter_user_image => "http://a0.twimg.com/sticky/default_profile_images/default_profile_6_normal.png", :deal_id => 1) }
  
  it "has an ActiveModel mass assignment method for content" do
    expect { tweet.send(:content) }.to_not raise_error(NoMethodError)
  end

  it "has an ActiveModel mass assignment method for twitter_username" do
    expect { tweet.send(:twitter_username) }.to_not raise_error(NoMethodError)
  end

  it "has an ActiveModel mass assignment method for twitter_user_image" do
    expect { tweet.send(:twitter_user_image) }.to_not raise_error(NoMethodError)
  end

  it "has an ActiveModel mass assignment method for deal_id" do
    expect { tweet.send(:deal_id) }.to_not raise_error(NoMethodError)
  end

  it "has an ActiveModel mass assignment method for user_id" do
    expect { tweet.send(:user_id) }.to_not raise_error(NoMethodError)
  end

  it "has a find_or_create_user method" do
    expect { tweet.send(:find_or_create_user) }.to_not raise_error(NoMethodError)
  end

  it "has a set_user_id method" do
    expect { tweet.send(:set_user_id) }.to_not raise_error(NoMethodError)
  end

  describe "#find_or_create_user" do

    context "when a user does not already exist" do

      it "creates a new user" do
        expect { tweet.find_or_create_user.should }.to change{ User.all.count }.by(1)
      end

      it "returns a user object" do
        tweet.find_or_create_user.should be_a_kind_of User
      end
    end

    context "when a user already exists" do
      let(:new_tweet) { Tweet.create(:twitter_username => "hungryfeedme1", :content => "second post!", :twitter_user_image => "http://a0.twimg.com/sticky/default_profile_images/default_profile_6_normal.png", :deal_id => 1) }
      let(:created_user) { User.create(:twitter_username => "hungryfeedme1") }

      it "returns a user object" do
        new_tweet.find_or_create_user.should be_a_kind_of User
      end

      it "returns the already existing user" do
        new_tweet.find_or_create_user.twitter_username.should == "hungryfeedme1"
      end
    end
  end

  describe "#set_user_id" do
    
  end
end
