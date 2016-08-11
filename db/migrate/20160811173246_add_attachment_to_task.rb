class AddAttachmentToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :attachment, :string
  end
end
