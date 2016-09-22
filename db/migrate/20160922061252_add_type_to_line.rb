class AddTypeToLine < ActiveRecord::Migration
  def change
    add_column :lines, :type, :string
  end
end
