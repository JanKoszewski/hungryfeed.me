require 'spec_helper'

describe TwitterParser do
  let(:twitter_parser) { TwitterParser.new }
  let(:twitter_data) { [ {"created_at"=>"Mon, 25 Jun 2012 14:27:42 +0000", "from_user"=>"SueAtwell", "from_user_id"=>28113624, "from_user_id_str"=>"28113624", "from_user_name"=>"Sue Atwell", "geo"=>nil, "id"=>217262799385141249, "id_str"=>"217262799385141249", "iso_language_code"=>"en", "metadata"=>{"result_type"=>"recent"}, "profile_image_url"=>"http://a0.twimg.com/profile_images/1227549926/SUE.ATWELL_normal.jpg", "profile_image_url_https"=>"https://si0.twimg.com/profile_images/1227549926/SUE.ATWELL_normal.jpg", "source"=>"&lt;a href=&quot;http://twitter.com/tweetbutton&quot; rel=&quot;nofollow&quot;&gt;Tweet Button&lt;/a&gt;", "text"=>"2-Hour Photo Booth Rental, Attendant, and Prints 1/2price!!!\nhttp://t.co/1wMMkQsG via @LivingSocial", "to_user"=>nil, "to_user_id"=>0, "to_user_id_str"=>"0", "to_user_name"=>nil}, {"created_at"=>"Mon, 25 Jun 2012 14:26:37 +0000", "from_user"=>"redrunningshoe", "from_user_id"=>380533117, "from_user_id_str"=>"380533117", "from_user_name"=>"Phaedra Kennedy", "geo"=>nil, "id"=>217262527392915456, "id_str"=>"217262527392915456", "iso_language_code"=>"en", "metadata"=>{"result_type"=>"recent"}, "profile_image_url"=>"http://a0.twimg.com/profile_images/1561351723/DOMREP_normal.jpg", "profile_image_url_https"=>"https://si0.twimg.com/profile_images/1561351723/DOMREP_normal.jpg", "source"=>"&lt;a href=&quot;http://twitter.com/tweetbutton&quot; rel=&quot;nofollow&quot;&gt;Tweet Button&lt;/a&gt;", "text"=>"Gonna get me some pearly whites! https://t.co/POwL26Uo via @LivingSocial", "to_user"=>nil, "to_user_id"=>0, "to_user_id_str"=>"0", "to_user_name"=>nil}, {"created_at"=>"Mon, 25 Jun 2012 14:25:26 +0000", "from_user"=>"BradsRawFoods", "from_user_id"=>52132491, "from_user_id_str"=>"52132491", "from_user_name"=>"BradsRawFoods", "geo"=>nil, "id"=>217262230134210563, "id_str"=>"217262230134210563", "iso_language_code"=>"en", "metadata"=>{"result_type"=>"recent"}, "profile_image_url"=>"http://a0.twimg.com/profile_images/1963328763/chipsfbpgimage_normal.jpg", "profile_image_url_https"=>"https://si0.twimg.com/profile_images/1963328763/chipsfbpgimage_normal.jpg", "source"=>"&lt;a href=&quot;http://www.hootsuite.com&quot; rel=&quot;nofollow&quot;&gt;HootSuite&lt;/a&gt;", "text"=>"We have 343 votes for the #missionsmallbusiness grant from @ChaseNews and @LivingSocial! Vote for us here: http://t.co/QV3gxJBM", "to_user"=>nil, "to_user_id"=>0, "to_user_id_str"=>"0", "to_user_name"=>nil} ] }

  it "should have a perform class method" do
    TwitterParser.respond_to?(:perform).should be_true
  end

  it "should have a find_link class method" do
    TwitterParser.respond_to?(:find_link).should be_true
  end

  it "should have a find_user class method" do
    TwitterParser.respond_to?(:find_user).should be_true
  end

  describe ".perform" do

    it "should raise an ArgumentError error if no parameters passed" do
      expect { TwitterParser.perform }.to raise_error(ArgumentError)
    end

    it "should return a an array" do
      TwitterParser.perform(twitter_data).should be_a Array
    end

    it "should return an array of links" do
      TwitterParser.perform(twitter_data).should == ["http://t.co/1wMMkQsG", "https://t.co/POwL26Uo"]
    end
  end

  describe ".find_link" do

    it "should raise an ArgumentError error if no parameters passed" do
      expect { TwitterParser.find_link }.to raise_error(ArgumentError)
    end

    context "when passed valid data" do
      let(:tweet_data) { twitter_data.first }

      it "should return a string" do
        TwitterParser.find_link(tweet_data).should be_a String
      end

      it "should return a string consisting of a link" do
        TwitterParser.find_link(tweet_data).should == "http://t.co/1wMMkQsG"
      end

    end

    context "when passed invalid data" do
      let(:tweet_data) { twitter_data.last }

      it "should return nil" do
        TwitterParser.find_link(tweet_data).should be_nil
      end

    end

  end

  describe ".find_user" do
    let(:tweet) { twitter_data.first }
    it "should raise an ArgumentError error if no parameters passed" do
      expect { TwitterParser.find_link }.to raise_error(ArgumentError)
    end

    it "should return a string" do
      TwitterParser.find_user(tweet).should be_a String
    end

    it "should return a string of a twitter user's handle" do
      TwitterParser.find_user(tweet).should == "SueAtwell"
    end

  end
end