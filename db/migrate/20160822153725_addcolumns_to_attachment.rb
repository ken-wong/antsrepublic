class AddcolumnsToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :attachmentable_id, :integer
    add_column :attachments, :attachmentable_type, :string
    remove_column :attachments, :task_id, :integer
  end
end
