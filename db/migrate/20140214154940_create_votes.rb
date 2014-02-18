class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true
      t.references :votable, polymorphic: true, index: true
      t.string :direction

      t.timestamps
    end

    add_index :votes, :direction
  end
end
