# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#Church.create(name: "", description: "Great Church", address: "", state: "MO", zipCode: "", city:"", denomination:"" )

if(!Church.where(:name => "Navigation Church").exists?)
  Church.create(name: "Navigation Church", address:"1205 Vandalia Street", state: "IL", zipCode: "62234", city:"Collinsville", denomination:"NonDenomination", latitude:"38.6823567", longitude:"-89.9778956")
end


# Denominations
if(!Denomination.where(:name => "NonDenomination").exists?)
  Denomination.create(name:"NonDenomination")
  Denomination.create(name:"Catholic")
  Denomination.create(name:"Baptist")
  Denomination.create(name:"Lutheran")
  Denomination.create(name:"First Assembly")
  Denomination.create(name:"Presbyterian")
  Denomination.create(name:"Methodist")
end
