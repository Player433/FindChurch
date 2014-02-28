class CreateChurches < ActiveRecord::Migration
  def change
    create_table :churches do |t|
      t.string :name, :null => false 
      t.string :address, :null => false
      t.string :state, :null => false, :limit => 16
      t.string :city, :null => false, :limit => 64
      t.string :zipCode, :null => false, :limit => 16
      t.string :denomination, :null => false
      t.float :latitude, :null => false
      t.float :longitude, :null => false
      t.boolean :gmaps
      t.string  :googleId

      t.timestamps
    end
  end
end
