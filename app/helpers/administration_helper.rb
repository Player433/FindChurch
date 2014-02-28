module AdministrationHelper
  # Public Helper method that adds Gmaps4Rails Entries to the Inbound_Church Table.
  def self.addFoundChurches(foundChurches)
    foundChurches.each do |church|
      #church = eval(church)
      @address = church[:vicinity].split(",")
      @denomination = getDenomination(church[:name])
      InboundChurch.create(:name => church[:name], :address => @address.at(0), :city => @address.at(1), :denomination => @denomination, :latitude => church[:lat], :longitude => church[:lng], 
        :googleId => church[:full_data]['id'], :website => church[:full_data]['html_attributions'])
      Preferences.applicationLogger("New Church Added to Staging: #{church[:name]}, #{@address[0]}, #{@address[1]}, #{church[:lat]}, #{church[:lng]}, #{church[:full_data]['html_attributions']}")
    end
  end
  
  # Determines church denomination based on what it finds in the name field.
 def self.getDenomination(churchName)
   if(churchName.include? "Catholic")
     return "Catholic"
   elsif(churchName.include? "Baptist")
     return "Baptist"
   elsif(churchName.include? "Lutheran")
     return "Lutheran"
   elsif(churchName.include? "Presbyterian")
     return "Presbyterian"
   elsif(churchName.include? "Methodist")
     return "Methodist"
   elsif(churchName.include? "First Assembly")
     return "First Assembly"
   elsif(churchName.include? "First Assemblies")
     return "First Assembly"
   end
 end
 
end
