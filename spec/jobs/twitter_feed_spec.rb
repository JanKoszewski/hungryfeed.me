require 'spec_helper'

describe TwitterFeed do

  it "should have a perform method" do
    TwitterFeed.respond_to?(:perform).should be_true
  end

  describe ".perform" do

    TWITTER_REGEX = /http:\/\/twitter.com/

    it "establishes a faraday connection" do
      pending #twitter_feed.perform.should respond 
    end

    it "responds with an array" do
      TwitterFeed.perform.should be_a Array
    end

    it "responds with an array of hashes" do
      TwitterFeed.perform.first.should be_a Hash
    end

  end
end