class RemoveColumnsToTask < ActiveRecord::Migration
  def change
    remove_column :tasks, :attachment, :string
    remove_column :tasks, :file_name, :string
  end
end
