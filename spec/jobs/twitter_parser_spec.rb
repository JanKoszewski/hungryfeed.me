require 'spec_helper'

describe TwitterParser do
  let(:twitter_parser) { TwitterParser.new }
  let(:twitter_data) { [ {"created_at"=>"Mon, 25 Jun 2012 14:27:42 +0000", "from_user"=>"SueAtwell", "from_user_id"=>28113624, "from_user_id_str"=>"28113624", "from_user_name"=>"Sue Atwell", "geo"=>nil, "id"=>217262799385141249, "id_str"=>"217262799385141249", "iso_language_code"=>"en", "metadata"=>{"result_type"=>"recent"}, "profile_image_url"=>"http://a0.twimg.com/profile_images/1227549926/SUE.ATWELL_normal.jpg", "profile_image_url_https"=>"https://si0.twimg.com/profile_images/1227549926/SUE.ATWELL_normal.jpg", "source"=>"&lt;a href=&quot;http://twitter.com/tweetbutton&quot; rel=&quot;nofollow&quot;&gt;Tweet Button&lt;/a&gt;", "text"=>"2-Hour Photo Booth Rental, Attendant, and Prints 1/2price!!!\nhttp://t.co/1wMMkQsG via @LivingSocial", "to_user"=>nil, "to_user_id"=>0, "to_user_id_str"=>"0", "to_user_name"=>nil}, {"created_at"=>"Mon, 25 Jun 2012 14:26:37 +0000", "from_user"=>"redrunningshoe", "from_user_id"=>380533117, "from_user_id_str"=>"380533117", "from_user_name"=>"Phaedra Kennedy", "geo"=>nil, "id"=>217262527392915456, "id_str"=>"217262527392915456", "iso_language_code"=>"en", "metadata"=>{"result_type"=>"recent"}, "profile_image_url"=>"http://a0.twimg.com/profile_images/1561351723/DOMREP_normal.jpg", "profile_image_url_https"=>"https://si0.twimg.com/profile_images/1561351723/DOMREP_normal.jpg", "source"=>"&lt;a href=&quot;http://twitter.com/tweetbutton&quot; rel=&quot;nofollow&quot;&gt;Tweet Button&lt;/a&gt;", "text"=>"Gonna get me some pearly whites! https://t.co/POwL26Uo via @LivingSocial", "to_user"=>nil, "to_user_id"=>0, "to_user_id_str"=>"0", "to_user_name"=>nil}, {"created_at"=>"Mon, 25 Jun 2012 21:40:52 +0000", "from_user"=>"napina", "from_user_id"=>23351208, "from_user_id_str"=>"23351208", "from_user_name"=>"Nadine", "geo"=>nil, "id"=>217371807441887233, "id_str"=>"217371807441887233", "iso_language_code"=>"en", "metadata"=>{"result_type"=>"recent"}, "profile_image_url"=>"http://a0.twimg.com/profile_images/2306337371/Dre3_normal.jpg", "profile_image_url_https"=>"https://si0.twimg.com/profile_images/2306337371/Dre3_normal.jpg", "source"=>"&lt;a href=&quot;http://blackberry.com/twitter&quot; rel=&quot;nofollow&quot;&gt;Twitter for BlackBerry&lt;/a&gt;", "text"=>"\"@Hallsy44: Kenny Chesney at FedExField https://t.co/rTRi2cEW via @LivingSocial ... Anyone in?\" I wish! Jealous.", "to_user"=>nil, "to_user_id"=>0, "to_user_id_str"=>"0", "to_user_name"=>nil}, {"created_at"=>"Mon, 25 Jun 2012 14:25:26 +0000", "from_user"=>"BradsRawFoods", "from_user_id"=>52132491, "from_user_id_str"=>"52132491", "from_user_name"=>"BradsRawFoods", "geo"=>nil, "id"=>217262230134210563, "id_str"=>"217262230134210563", "iso_language_code"=>"en", "metadata"=>{"result_type"=>"recent"}, "profile_image_url"=>"http://a0.twimg.com/profile_images/1963328763/chipsfbpgimage_normal.jpg", "profile_image_url_https"=>"https://si0.twimg.com/profile_images/1963328763/chipsfbpgimage_normal.jpg", "source"=>"&lt;a href=&quot;http://www.hootsuite.com&quot; rel=&quot;nofollow&quot;&gt;HootSuite&lt;/a&gt;", "text"=>"We have 343 votes for the #missionsmallbusiness grant from @ChaseNews and @LivingSocial! Vote for us here: http://t.co/QV3gxJBM", "to_user"=>nil, "to_user_id"=>0, "to_user_id_str"=>"0", "to_user_name"=>nil} ] }
  let(:tweet_data) { twitter_data.first }
  let(:bad_ls_tweet_data) { twitter_data[2] }
  let(:no_ls_tweet_data) { twitter_data.last }
  let(:deal) { Deal.create(:link => "http://www.livingsocial.com/deals/336350-2-hour-photo-booth-rental-attendant-and-prints", :purchased => 41, :image => "http://a3.ak.lscdn.net/imgs/dc2a04cd-5724-4c87-bdde-8869b3bf8c27/280_q60_.jpg") }
  let(:first_link) { Rails.root.to_s + "/spec/fixtures/twitter_data/first_tweet_link.html" }
  let(:second_link) { Rails.root.to_s + "/spec/fixtures/twitter_data/second_tweet_link.html" }

  # before do

  #   first_link = Rails.root.to_s + "/spec/fixtures/twitter_data/first_tweet_link.html"
  #   second_link = Rails.root.to_s + "/spec/fixtures/twitter_data/second_tweet_link.html"
  #   third_link = Rails.root.to_s + "/spec/fixtures/twitter_data/third_tweet_link.html"
  #   fourth_link = Rails.root.to_s + "/spec/fixtures/twitter_data/second_tweet_link.html"

  #   TwitterParser.should_receive(:parse_deal_page).
  #     with("http://www.livingsocial.com/cities/852-grosse-pointe-macomb-county").
  #     and_return(first_link)

    # TwitterParser.should_receive(:find_link).
    #   with(twitter_data[0]).
    #   and_return(first_link)

    # TwitterParser.should_receive(:find_link).
    #   with(twitter_data[1]).
    #   and_return(second_link)

    # TwitterParser.should_receive(:find_link).
    #   with(twitter_data[2]).
    #   and_return(second_link)

    # TwitterParser.should_receive(:find_link).
    #   with(twitter_data[3]).
    #   and_return(fourth_link)

    # TwitterParser.perform(twitter_data)

  # end

  it "should have a perform class method" do
    TwitterParser.respond_to?(:perform).should be_true
  end

  it "should have a find_link class method" do
    TwitterParser.respond_to?(:find_link).should be_true
  end

  it "should have a create_tweet_from class method" do
    TwitterParser.respond_to?(:create_tweet_from).should be_true
  end

  it "should have a create_deal_from class method" do
    TwitterParser.respond_to?(:create_deal_from).should be_true
  end

  it "should have a validate_deal_with class method" do
    TwitterParser.respond_to?(:validate_link).should be_true
  end

  describe ".perform" do

    it "should raise an ArgumentError error if no parameters passed" do
      expect { TwitterParser.perform }.to raise_error(ArgumentError)
    end

    context "when a LivingSocial deal link is found" do

      it "creates a new Deal object" do
        TwitterParser.should_receive(:open).
          with("http://www.livingsocial.com/cities/852-grosse-pointe-macomb-county").
          and_return(first_link)

        expect { TwitterParser.perform(twitter_data) }.to change{ Deal.all.count }.by(2)
      end

      it "creates a new Tweet object" do
        TwitterParser.should_receive(:open).
          with("http://www.livingsocial.com/cities/852-grosse-pointe-macomb-county").
          and_return(first_link)

        expect { TwitterParser.perform(twitter_data) }.to change{ Tweet.all.count }.by(2)
      end

      it "establishes a has-many relationship between the created deal and corresponding tweet" do
        TwitterParser.should_receive(:open).
          with("http://www.livingsocial.com/cities/852-grosse-pointe-macomb-county").
          and_return(first_link)

        TwitterParser.perform(twitter_data)
        Deal.all.each do |deal|
          deal.tweets.count.should == 1
        end
      end
    end
  end

  describe ".find_link" do

    it "should raise an ArgumentError error if no parameters passed" do
      expect { TwitterParser.find_link }.to raise_error(ArgumentError)
    end

    context "when passed valid data" do

      it "should return a string" do
        TwitterParser.find_link(tweet_data).should be_a String
      end

      it "should return a string consisting of a link" do
        TwitterParser.find_link(tweet_data).should == "http://www.livingsocial.com/cities/852-grosse-pointe-macomb-county"
      end
    end

    context "when passed invalid data" do

      it "should return the invalid link" do
        TwitterParser.find_link(no_ls_tweet_data).should == "https://www.missionsmallbusiness.com/"
      end
    end
  end

  describe ".create_tweet_from" do

    it "should raise an ArgumentError error if no parameters passed" do
      expect { TwitterParser.create_tweet_from }.to raise_error(ArgumentError)
    end

    it "should raise an ArgumentError error if only one parameter is passed" do
      expect { TwitterParser.create_tweet_from("tweet") }.to raise_error(ArgumentError)
    end

    context "when passed valid tweet data" do

      it "should return a Tweet object" do
        TwitterParser.create_tweet_from(tweet_data, deal.id).should be_a_kind_of(Tweet)
      end

      it "should return a Tweet object whose content contains a link to a LivingSocial deal" do
        tweet_content = { "text" => TwitterParser.create_tweet_from(tweet_data, deal.id).content }
        TwitterParser.find_link(tweet_content).should == "http://www.livingsocial.com/cities/852-grosse-pointe-macomb-county"
      end

    end
  end

  describe ".create_deal_from" do

    it "should raise an ArgumentError error if no parameters passed" do
      expect { TwitterParser.create_deal_from }.to raise_error(ArgumentError)
    end

    context "when passed valid data" do

      it "should return a Deal object" do

        TwitterParser.should_receive(:open).
          with("http://www.livingsocial.com/cities/852-grosse-pointe-macomb-county").
          and_return(first_link)

        TwitterParser.create_deal_from(TwitterParser.find_link(tweet_data)).should be_a_kind_of(Deal)
      end

      it "should return a Deal object referenced by a LivingSocial Deal link" do

        TwitterParser.should_receive(:open).
          with("http://www.livingsocial.com/cities/852-grosse-pointe-macomb-county").
          and_return(first_link)

        TwitterParser.create_deal_from(TwitterParser.find_link(tweet_data)).link.should == "http://www.livingsocial.com/cities/852-grosse-pointe-macomb-county/deals/336350-2-hour-photo-booth-rental-attendant-and-prints"
      end
    end
  end

  describe "validate_link" do

    context "when passed an invalid local deal link" do

      it "should return false" do
        TwitterParser.validate_link(TwitterParser.find_link(bad_ls_tweet_data)).should be_false
      end
    end

    context "when passed a valid local deal link" do

      it "should return true" do
        TwitterParser.validate_link(TwitterParser.find_link(tweet_data)).should be_true
      end
    end
  end
end