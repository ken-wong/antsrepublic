class AddQueenIdToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :queen, index: true, foreign_key: true
  end
end
