class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :avatar
      t.string :client_name
      t.string :ref_price
      t.string :category_id
      t.string :main_img
      t.text :description

      t.timestamps null: false
    end
  end
end
