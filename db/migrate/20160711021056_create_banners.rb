class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :title
      t.string :image
      t.string :state

      t.timestamps null: false
    end
  end
end
