require 'spec_helper'

describe Tweet do
  let(:deal) { Deal.create(:link => "http://www.livingsocial.com/cities/1-washington-d-c/deals/315382-one-month-gym-membership", :purchased => 192, :title => "Crunch Fitness") }
  let(:tweet) { Tweet.create(:twitter_username => "jkoszewski", :twitter_user_image => "http://a0.twimg.com/sticky/default_profile_images/default_profile_6_normal.png", :deal_id => deal.id) }
  
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
      let(:new_tweet) { Tweet.create(:twitter_username => "jkoszewski", :content => "second post!", :twitter_user_image => "http://a0.twimg.com/sticky/default_profile_images/default_profile_6_normal.png", :deal_id => deal.id) }
      let(:created_user) { User.create(:twitter_username => "jkoszewski") }

      it "returns a user object" do
        new_tweet.find_or_create_user.should be_a_kind_of User
      end

      it "returns the already existing user" do
        new_tweet.find_or_create_user.twitter_username.should == "jkoszewski"
      end
    end
  end

  describe "#set_user_id" do

    it "sets the user_id of the tweet to that of the tweet's user" do
      tweet.set_user_id
      tweet.user_id.should == User.find_by_twitter_username("jkoszewski").id
    end
  end
end
