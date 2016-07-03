class MoreFieldsForUsers < ActiveRecord::Migration
  def change
    add_column :users, :company, :string
    add_column :users, :avatar, :string
  end
end
