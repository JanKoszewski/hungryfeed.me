class Authentication < ActiveRecord::Base
  attr_accessible :provider, :uid, :access_token
  belongs_to :user
end
