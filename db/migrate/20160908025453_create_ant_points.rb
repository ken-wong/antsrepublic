class CreateAntPoints < ActiveRecord::Migration
  def change
    create_table :ant_points do |t|
      t.integer :total_amounts
      t.integer :total_projects
      t.integer :total_ants

      t.timestamps null: false
    end
  end
end
