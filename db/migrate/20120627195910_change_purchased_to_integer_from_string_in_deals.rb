class ChangePurchasedToIntegerFromStringInDeals < ActiveRecord::Migration
  def change
  	remove_column :deals, :purchased, :string
    add_column :deals, :purchased, :integer
  end
end
