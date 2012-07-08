class Authentication < ActiveRecord::Base
  attr_accessible :provider, :uid, :access_token, :oauth_token, :oauth_token_secret
  belongs_to :user
end
