class AddDealIdToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :deal_id, :integer
    add_index :tweets, :deal_id
  end
end
