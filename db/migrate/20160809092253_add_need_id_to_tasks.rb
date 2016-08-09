class AddNeedIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :need_id, :integer, limit: 4
  end
end
