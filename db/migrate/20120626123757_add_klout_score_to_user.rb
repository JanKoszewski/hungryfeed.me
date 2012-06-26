class AddKloutScoreToUser < ActiveRecord::Migration
  def change
    add_column :users, :klout_score, :integer
  end
end
