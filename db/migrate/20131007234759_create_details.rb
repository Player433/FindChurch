class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.references :church, index: true
      t.text :description
      t.string :website
      t.integer :members
      t.string :school
      t.string :rating

      t.timestamps
    end
  end
end
