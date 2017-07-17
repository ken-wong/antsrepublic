class AddWxOpenidToUser < ActiveRecord::Migration
  def change
    add_column :users, :wx_openid, :string
  end
end
