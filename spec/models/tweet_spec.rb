require 'spec_helper'

describe Tweet do
  let(:tweet) { Tweet.new }
  
  it "has an ActiveModel mass assignment method for content" do
    expect { tweet.send(:content) }.to_not raise_error(NoMethodError)
  end

  it "has an ActiveModel mass assignment method for content" do
    expect { tweet.send(:twitter_username) }.to_not raise_error(NoMethodError)
  end

  it "has an ActiveModel mass assignment method for content" do
    expect { tweet.send(:twitter_user_image) }.to_not raise_error(NoMethodError)
  end

end
