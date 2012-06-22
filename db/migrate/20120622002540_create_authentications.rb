class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :user_id
      t.string :provider
      t.integer :uid
      t.string :access_token

      t.timestamps
    end
    add_index :authentications, :user_id
    add_index :authentications, :uid
    add_index :authentications, :access_token
  end
end
