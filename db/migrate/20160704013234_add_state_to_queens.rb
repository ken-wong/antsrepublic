class AddStateToQueens < ActiveRecord::Migration
  def change
    add_column :queens, :state, :string
    add_column :queens, :desc, :text
  end
end
