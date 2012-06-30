class AddIndexToUserIdTweets < ActiveRecord::Migration
  def change
  	add_index :tweets, :user_id
  	add_index :tweets, :twitter_username
  end
end
