class CreateDenominations < ActiveRecord::Migration
  def change
    create_table :denominations do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end
end
