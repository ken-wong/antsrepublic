class AddIsCaseToNeed < ActiveRecord::Migration
  def change
    add_column :products, :is_case, :boolean, default: false
  end
end
