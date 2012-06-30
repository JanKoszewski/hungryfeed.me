class CreateDealEmails < ActiveRecord::Migration
  def change
    create_table :deal_emails do |t|
    	t.integer :tweet_id
    	t.string :email
    	t.string :deal_link

      t.timestamps
    end
  end
end
