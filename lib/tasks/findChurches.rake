
desc "Add All inbound Churches that meet the requirements"
task :addToMaster => :environment do
  InboundChurch.all().find_each() do |church|
      @newChurch = Church.new(:name => church.name, :address => church.address, :city => church.city, :state => church.state, :zipCode => church.zipCode, :latitude => church.latitude, 
        :longitude => church.longitude, :googleId => church.googleId, :denomination => church.denomination, :details_attributes => {:website => church.website})

      if(@newChurch.valid? && @newChurch.save)
        church.delete
        Preferences.jobLogger("New Church Added to Main: #{church.name}, #{church.address}, #{church.city}, #{church.denomination}")
      else
        Preferences.jobLogger("Church Not Added - Name: #{church.name}, Error: #{@newChurch.errors.full_messages}")
      end

  end
end

desc "Searches for new churches by cycling through all zip codes and adding them to the staging table"
task :findChurches => :environment do
  @zipCodeList = getNextCodeList()
  
  @zipCodeList.each do |zipCode|
    puts "Rake Task - Adding all churches found under Zip Code #{zipCode}"
    
    begin
      @foundChurches = Gmaps4rails.places_for_address(zipCode.to_s().rjust(5, '0'), Preferences.apiKey, 'Church', 10000)
    rescue Gmaps4rails::GeocodeInvalidQuery => e
      Preferences.jobLogger("Invalid Query: No churches were found in the results, zip code = #{zipCode}")
    rescue Gmaps4rails::GeocodeStatus => e
      Preferences.jobLogger("Invalid Query: The address you passed seems invalid, status was: ZERO_RESULTS, zip code = #{zipCode}")
    rescue Gmaps4rails::PlacesStatus => e
      Preferences.jobLogger("#{e}")
    end
    
    # Log all Found churches
    @foundChurches.each {|c| puts "  #{c.name}" }
    
    if(!@foundChurches.blank?)
      AdministrationHelper.addFoundChurches(@foundChurches)
    end
    # Sleep to prevent Google from complaining about too much data
    sleep(2.seconds)
  end
end

desc "Retrieves all ZipCodes."
task :zipCodeTest do
  @allZip = getAllZipCodes()
  puts "ALL VALID CODES = #{@allZip}, count = #{@allZip.count}"
end

# ---------------------------------------- Local Methods -------------------------------------------------------

def self.getNextCodeList
  @evenOddSelector = !@evenOddSelector
  
  if (@evenOddSelector)
    getAllZipCodes.select {|num| num.even?}
  else
    getAllZipCodes.select {|num| num.odd?}
  end
end

# ALL Valid zip codes in the United States. 1056 in total.
def self.getAllZipCodes
  @allValidCodes = Array.new
  @allValidCodes += (35801..35816).to_a #Alabama
  @allValidCodes += (99501..99524).to_a #Alaska
  @allValidCodes += (85001..85055).to_a #Arizona
  @allValidCodes += (72201..72217).to_a #Arkansas
  @allValidCodes += (90001..90089).to_a #California 1
  @allValidCodes += (90209..90213).to_a #California 2
  @allValidCodes += (94203..94209).to_a #California 3
  @allValidCodes += (80120..80128).to_a #Colorado 1
  @allValidCodes += (80201..80239).to_a #Colorado 2
  @allValidCodes += (06101..06112).to_a #Conneticut
  @allValidCodes += (19901..19905).to_a #Deleware
  @allValidCodes += (20001..20020).to_a #District Of Columbia
  @allValidCodes += (32501..32509).to_a #Florida 1
  @allValidCodes += (32801..32837).to_a #Florida 2
  @allValidCodes += (33124..33190).to_a #Florida 3
  @allValidCodes += (30301..30381).to_a #Georgia
  @allValidCodes += (96801..96830).to_a #Hawaii
  @allValidCodes << (83254)             #Idaho
  @allValidCodes += (60601..60641).to_a #Illinois 1
  @allValidCodes += (62701..62709).to_a #Illinois 2
  @allValidCodes += (46201..46209).to_a #Indiana
  @allValidCodes += (50301..50323).to_a #Iowa 1
  @allValidCodes += (52801..52809).to_a #Iowa 2
  @allValidCodes += (67201..67221).to_a #Kansas
  @allValidCodes += (41701..41702).to_a #Kentucky
  @allValidCodes += (70112..70119).to_a #Louisianna
  @allValidCodes += (04032..04034).to_a #Maine
  @allValidCodes += (21201..21237).to_a #Maryland
  @allValidCodes += (02101..02137).to_a #Massechussets
  @allValidCodes << (49036)             #Michigan 1
  @allValidCodes += (49734..49735).to_a #Michigan 2
  @allValidCodes += (55801..55808).to_a #Minnesota
  @allValidCodes += (39530..39535).to_a #Mississippi
  @allValidCodes += (63101..63141).to_a #Missouri
  @allValidCodes << (59044)             #Montana
  @allValidCodes += (68901..68902).to_a #Nebraska
  @allValidCodes += (89501..89513).to_a #Nevada
  @allValidCodes << (03217)             #New Hampshire
  @allValidCodes << (7039)              #New Jersey
  @allValidCodes += (87500..87506).to_a #New Mexico
  @allValidCodes += (10001..10048).to_a #New York
  @allValidCodes << (27565)             #North Carolina
  @allValidCodes << (58282)             #North Dakota
  @allValidCodes += (44101..44179).to_a #Ohio
  @allValidCodes += (74101..74110).to_a #Oklahoma
  @allValidCodes += (97201..97225).to_a #Oregon
  @allValidCodes += (15201..15244).to_a #Pennsylvania
  @allValidCodes += (2840..2841).to_a   #Rhode Island
  @allValidCodes << (29020)             #South Carolina
  @allValidCodes += (57401..57402).to_a #South Dakota
  @allValidCodes += (78701..78705).to_a #Texas
  @allValidCodes += (84321..84323).to_a #Utah
  @allValidCodes << (05751)             #Vermont
  @allValidCodes << (24517)             #Virginia
  @allValidCodes += (98004..98009).to_a #Washington
  @allValidCodes << (25813)             #West Virginia
  @allValidCodes += (53201..53228).to_a #Wisconsin
  @allValidCodes << (82941)             #Wyoming
end






