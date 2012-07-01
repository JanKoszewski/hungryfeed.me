class AddDealIdToDealEmailsAgain < ActiveRecord::Migration
  def change
  	add_column :deal_emails, :deal_id, :integer
    add_index :deal_emails, :deal_id
  end
end
