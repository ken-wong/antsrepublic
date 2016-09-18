class AddAntTexttoAntPoint < ActiveRecord::Migration
  def change
  	add_column :ant_points, :ants_text, :text
  end
end
