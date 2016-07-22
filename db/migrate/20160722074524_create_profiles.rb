class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :phone
      t.string :company
      t.string :qq
      t.string :wechat
      t.string :verify_img1
      t.string :verify_img2
      t.string :verify_img3
      t.string :address
      t.string :other

      t.timestamps null: false
    end
  end
end
