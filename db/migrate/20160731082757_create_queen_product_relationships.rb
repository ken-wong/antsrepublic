class CreateQueenProductRelationships < ActiveRecord::Migration
  def change
    create_table :queen_product_relations do |t|
      t.integer :user_id
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
