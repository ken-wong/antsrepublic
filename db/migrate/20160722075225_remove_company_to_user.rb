class RemoveCompanyToUser < ActiveRecord::Migration
  def change
    remove_column :users, :company, :string
  end
end
