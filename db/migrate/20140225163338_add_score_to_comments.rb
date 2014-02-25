class AddScoreToComments < ActiveRecord::Migration
  def change
    add_column :comments, :score, :integer, default: 0
  end
end
