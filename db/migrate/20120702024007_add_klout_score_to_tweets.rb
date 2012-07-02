class AddKloutScoreToTweets < ActiveRecord::Migration
  def change
  	add_column :tweets, :klout_score, :integer
  	add_index :tweets, :klout_score
  end
end
