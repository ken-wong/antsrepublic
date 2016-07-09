class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :media
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
