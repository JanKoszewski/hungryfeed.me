class ChangeTweetResponseUserAndTweetIdsToInt < ActiveRecord::Migration
  def change
  	remove_column :tweet_responses, :user_id, :string
  	remove_column :tweet_responses, :tweet_id, :string
    add_column :tweet_responses, :user_id, :integer
  	add_column :tweet_responses, :tweet_id, :integer
  end
end