class AddSortNoToUser < ActiveRecord::Migration
  def change
    add_column :users, :sort_no, :integer,:default => 0
  end
end
