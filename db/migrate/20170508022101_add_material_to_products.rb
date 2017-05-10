class AddMaterialToProducts < ActiveRecord::Migration
  def change
    add_column :products, :material_name, :string
    add_column :products, :remark, :text
  end
end
