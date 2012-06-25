class AddTwitterUserImageToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :twitter_user_image, :string
  end
end
