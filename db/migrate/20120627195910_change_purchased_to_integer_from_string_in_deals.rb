class ChangePurchasedToIntegerFromStringInDeals < ActiveRecord::Migration
  def change
  	remove_column :deals, :purchased
    add_column :deals, :purchased, :integer
  end
end
