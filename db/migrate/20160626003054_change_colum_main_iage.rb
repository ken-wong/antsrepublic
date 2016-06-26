class ChangeColumMainIage < ActiveRecord::Migration
  def change
  	rename_column :products, :main_img, :main_media
  end
end
