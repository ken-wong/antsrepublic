class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.date :dead_line
      t.string :title
      t.text :description
      t.string :state

      t.timestamps null: false
    end
  end
end
