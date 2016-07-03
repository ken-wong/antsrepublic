class CreateQueens < ActiveRecord::Migration
  def change
    create_table :queens do |t|
      t.string :email
      t.string :name
      t.string :cell
      t.string :company
      t.string :avatar
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
