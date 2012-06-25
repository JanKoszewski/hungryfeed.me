class RemoveUserAndAddTwitterUsernameToTweets < ActiveRecord::Migration
  def change
    remove_column :tweets, :user, :string
    add_column :tweets, :twitter_username, :string
  end
end
