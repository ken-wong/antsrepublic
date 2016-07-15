class CreateNeeds < ActiveRecord::Migration
  def change
    create_table :needs do |t|

      t.timestamps null: false
    end
  end
end
