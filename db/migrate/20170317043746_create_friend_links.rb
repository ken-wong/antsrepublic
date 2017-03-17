class CreateFriendLinks < ActiveRecord::Migration
  def change
    create_table :friend_links do |t|
      t.string :banner
      t.string :linkage
      t.string :title

      t.timestamps null: false
    end
  end
end
