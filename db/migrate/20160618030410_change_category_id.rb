class ChangeCategoryId < ActiveRecord::Migration
  def change
  	rename_column :products, :category_id, :category
  	
  end
end
