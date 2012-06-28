class CreateTweetResponses < ActiveRecord::Migration
  def change
    create_table :tweet_responses do |t|
    	t.string :user_id
      t.string :tweet_id
      t.string :content

      t.timestamps
    end
  end
end
