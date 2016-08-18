class RenameColumnAttachment < ActiveRecord::Migration
  def change
  	rename_column :attachments, :name, :file_name
  end
end
