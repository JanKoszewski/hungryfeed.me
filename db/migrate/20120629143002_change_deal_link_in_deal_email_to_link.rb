class ChangeDealLinkInDealEmailToLink < ActiveRecord::Migration
  def change
  	remove_column :deal_emails, :deal_link, :string
    add_column :deal_emails, :link, :string
    add_index :deal_emails, :tweet_id
    add_index :deal_emails, :link
  end
end
