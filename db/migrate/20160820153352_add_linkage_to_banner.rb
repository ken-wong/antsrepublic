class AddLinkageToBanner < ActiveRecord::Migration
  def change
    add_column :banners, :linkage, :string
  end
end
