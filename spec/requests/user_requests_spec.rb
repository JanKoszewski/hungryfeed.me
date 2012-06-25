require 'spec_helper'

describe "User" do
  context "when visiting the home page" do
    before do
      visit root_url
    end

    it "displays an 'Login with Twitter' button" do
      
      page.should have_link("Login with Twitter")
    end

    it "displays a 'Skip authentication' link" do
      visit root_url
      page.should have_link("Skip authentication")
    end

    context "when a user clicks 'Login with Twitter'" do

      it "should redirect to a twitter authentication page" do
        
        click_link('Login with Twitter')
        
        page.should have_content "Authorize hungryfeed to use your account?"
      end

    end

  end
end
