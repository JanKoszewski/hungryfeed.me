class AddTitleToDeal < ActiveRecord::Migration
  def change
    add_column :deals, :title, :string
  end
end
