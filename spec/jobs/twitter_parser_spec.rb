require 'spec_helper'

describe TwitterParser do
  let(:twitter_parser) { TwitterParser.new }

  it "should have a perform class method" do
    TwitterParser.respond_to?(:perform).should be_true
  end

  it "should have a find_link instance method" do
    twitter_parser.respond_to?(:find_link).should be_true
  end

  describe ".perform" do

    it "should raise an ArgumentError error if no parameters passed" do
      expect { TwitterParser.perform }.to raise_error(ArgumentError)
    end

  end

  describe "#find_link" do

    it "should raise an ArgumentError error if no parameters passed" do
      expect { twitter_parser.find_link }.to raise_error(ArgumentError)
    end

    context "when passed valid data" do
      let(:tweet_data) { { "text" => "$200 to Spend on Complete Pair of Glasses http://t.co/3gDQ6AST via @LivingSocial" } }

      it "should return a string" do
        twitter_parser.find_link(tweet_data).should be_a String
      end

      it "should return a string consisting of a link" do
        twitter_parser.find_link(tweet_data).should == "http:\/\/t.co/3gDQ6AST"
      end

    end

    context "when passed invalid data" do
      let(:tweet_data) { { "text" => "We have 343 votes for the #missionsmallbusiness grant from @ChaseNews and @LivingSocial! Vote for us here: http://t.co/QV3gxJBM" } }

      it "should return nil" do
        twitter_parser.find_link(tweet_data).should be_nil
      end
    end

  end
end