class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.date :dead_line
      t.string :title
      t.integer :need_id

      t.timestamps null: false
    end
  end
end
