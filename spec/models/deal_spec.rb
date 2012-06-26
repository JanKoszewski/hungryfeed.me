require 'spec_helper'

describe Deal do
  let(:deal) { Deal.new }
  
  it "has an ActiveModel mass assignment method for content" do
    expect { deal.send(:link) }.to_not raise_error(NoMethodError)
  end

  it "has an ActiveModel mass assignment method for content" do
    expect { deal.send(:purchased) }.to_not raise_error(NoMethodError)
  end

  it "has an ActiveModel mass assignment method for content" do
    expect { deal.send(:image) }.to_not raise_error(NoMethodError)
  end
end
