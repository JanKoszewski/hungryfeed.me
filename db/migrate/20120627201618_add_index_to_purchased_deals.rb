class AddIndexToPurchasedDeals < ActiveRecord::Migration
  def change
  	add_index :deals, :purchased
  end
end
