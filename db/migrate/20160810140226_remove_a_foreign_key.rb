class RemoveAForeignKey < ActiveRecord::Migration
  def up
    remove_foreign_key :products, :queens
  end

  def down
    add_foreign_key :products, :queens
  end
end
