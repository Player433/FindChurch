class HomeController < ApplicationController
  
  def index
    @searchString = getSearchString(params[:search])
    @range = params[:range].present? ? params[:range] : 20
    puts "Search String = #{@searchString}"
    
    if (params[:selectedDenominations].present?)
      @churchList = Church.where(:denomination => params[:selectedDenominations]).near(@searchString, @range)
    else
      @churchList = Church.near(@searchString, @range)
    end
    
    @json = jsonResults(@churchList)
    
    puts "GeoLocation.postalCode = #{request.location.postal_code}"
    puts "GeoLocation = #{request.location.to_yaml}"
    
    # Did we find anything?  If empty, then set to default search.
    if (@json.blank? || @json == "[]")
      flash[:notice] = "No churches were found in the results"
      Preferences.actionLogger("No Churches found in search for #{params[:search]}")
      @json = Preferences.defaultLocation
    end
    
    @denominations = Denomination.all_cached
    
    render action: 'index'
  end # index
  
  
  def about
    
  end # about
  
  def contact
    
  end # contact
  
  #-------------------------- Private Methods --------------------------------
  private
  
  def jsonResults(foundLocations)
    puts "Found Locations = #{foundLocations.to_yaml}"
    
    @json = foundLocations.to_gmaps4rails do |church, marker|
      puts "Church = #{church.to_yaml}"
      marker.title "#{church.name}"
      marker.picture({:picture => "/mapIcons/#{church.denomination}.png", :width => 32, :height => 32})
    end
  end
  
  # Attempts to return parameter Search string if available.
  # If search String not available, then return IP address Zip Code.
  # If IP Zip Code not available, then just return St.Louis zip code.
  def getSearchString(searchString)
    return params[:search] if (params[:search].present?)
    
    @IP_ZipCode = request.location.postal_code
    return @IP_ZipCode if (@IP_ZipCode.present?)
    
    return "63101"
  end
  
  
end # class
