class CreateNeedImgs < ActiveRecord::Migration
  def change
    create_table :need_imgs do |t|
      t.string :photo
      t.references :need
      t.timestamps null: false
    end
  end
end
