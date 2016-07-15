class AddColumnsToProduct < ActiveRecord::Migration
  def change
  	add_column :products, :start_date, :date
  	add_column :products, :ending_date, :date
  	add_column :products, :final_date, :date
  	add_column :products, :state, :string
  	add_column :products, :price_range, :string
  end
end
