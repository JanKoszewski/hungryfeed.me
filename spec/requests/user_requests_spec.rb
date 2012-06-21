require 'spec_helper'

describe "User" do
  context "when visiting the home page" do
    it "displays an 'Login with Twitter' button" do
      visit root_url
      page.should have_link("Login with Twitter")
    end
  end
end
