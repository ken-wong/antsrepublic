class MoreFieldsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :reference_product_ids, :string
    add_column :products, :reference_queen_ids, :string
  end
end
