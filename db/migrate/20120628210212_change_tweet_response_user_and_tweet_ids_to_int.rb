class ChangeTweetResponseUserAndTweetIdsToInt < ActiveRecord::Migration
  def change
  	remove_column :tweet_responses, :user_id
  	remove_column :tweet_responses, :tweet_id
    add_column :tweet_responses, :user_id, :integer
  	add_column :tweet_responses, :tweet_id, :integer

  	add_index :tweet_responses, :user_id
    add_index :tweet_responses, :tweet_id
  end
end
