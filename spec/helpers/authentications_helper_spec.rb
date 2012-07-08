require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the AuthenticationsHelper. For example:
#
# describe AuthenticationsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe AuthenticationsHelper do
  describe "#login_path" do
  	context "when in Production environment" do
  		it "returns a hungryfeedme.herokuapp url" do
  			Rails.env = 'production'
  			login_path = "href='http://hungryfeedme.herokuapp.com/auth/twitter'"
  		end
  	end

  	context "when in development environment" do
  		it "returns a lvh.me url" do
  			Rails.env = 'development'
  			login_path = "href='http://lvh.me:3000/auth/twitter'"
  		end
  	end
  end
end
