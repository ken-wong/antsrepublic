class AddFileNameToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :file_name, :string
  end
end
