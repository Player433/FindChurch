class CreateInboundChurches < ActiveRecord::Migration
  def change
    create_table :inbound_churches do |t|
      t.string :name, :null => false
      t.text :description
      t.string :address
      t.string :state
      t.string :city
      t.string :zipCode
      t.string :denomination
      t.string :website
      t.float :latitude, :null => false
      t.float :longitude, :null => false
      t.boolean :gmaps
      t.string  :googleId

      t.timestamps
    end
  end
end
