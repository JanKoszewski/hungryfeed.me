require 'spec_helper'

describe DealEmail do
	let(:deal_email) { DealEmail.new(:email => "hungryfeedme@gmail.com") }
	let(:invalid_deal_email) { DealEmail.new }
  
  it "has an ActiveModel mass assignment method for content" do
    expect { deal.send(:deal_id) }.to_not raise_error(NoMethodError)
  end

  it "has an ActiveModel mass assignment method for purchased" do
    expect { deal.send(:tweet_id) }.to_not raise_error(NoMethodError)
  end

  it "has an ActiveModel mass assignment method for image" do
    expect { deal.send(:link) }.to_not raise_error(NoMethodError)
  end

  it "has an ActiveModel mass assignment method for image" do
    expect { deal.send(:email) }.to_not raise_error(NoMethodError)
  end

  it "validates the presence of email before being saved" do
  	expect { invalid_deal_email.save! }.to raise_error
  end
end
