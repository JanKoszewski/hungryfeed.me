class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :link
      t.string :purchased
      t.string :image

      t.timestamps
    end

   add_index :deals, :link
  end
end
