class AdministrationController < ApplicationController
  
  def index
  end
  
  def newChurches
    @newChurchList = InboundChurch.paginate(:page => params[:page])
  end
  
  def churchManagement
    @churchList = Church.paginate(:page => params[:page])
  end
  
  def findNewChurches
    if (params.has_key?(:search) && params[:search].present?)
      begin
        @foundChurches = Gmaps4rails.places_for_address(params[:search], Preferences.apiKey, 'Church', 10000)
      rescue Gmaps4rails::GeocodeInvalidQuery => e
        flash[:notice] = "Invalid Query: No churches were found in the results"
      rescue Gmaps4rails::GeocodeStatus => e
        flash[:notice] = "Invalid Query: The address you passed seems invalid, status was: ZERO_RESULTS"
      rescue Gmaps4rails::PlacesStatus => e
        flash[:notice] = "#{e}"
      end
    
      if (@foundChurches.blank?)
        Preferences.actionLogger("Found Churches was empty")
      else
        Preferences.actionLogger("Found Churches were greater than 100 results.") if (@foundChurches.count >= 100)
          
        @newChurchList = Array.new
        @foundChurches.each do |foundChurch|
          if(Church.matches(foundChurch).blank? && InboundChurch.matches(foundChurch).blank?)
            @newChurchList << foundChurch
          end
        end
      end
    end 
  end
  
  # Submits new churches from search field to the staging church table.
  def addChurches
    if (!params[:newChurch_ids].blank?)
      @selectedChurches = Array.new(params[:newChurch_ids])
      addFoundChurches(@selectedChurches)
      
      flash[:notice] = "Successfully added #{@selectedChurches.count()} new #{'church'.pluralize(@selectedChurches.count())}"
    end
    
    redirect_to administration_newChurches_path
  end
  
  # Moves churches from the staging table to the master table.
  def moveToMain
    if(!params[:newChurch_ids].blank?)
      @selectedChurches = InboundChurch.find(params[:newChurch_ids])
      
      if(!@selectedChurches.blank?)
        @selectedChurches.each do |church|
          @newChurch = Church.new(:name => church.name, :address => church.address, :city => church.city, :state => church.state, :zipCode => church.zipCode, :latitude => church.latitude, 
            :longitude => church.longitude, :googleId => church.googleId, :denomination => church.denomination, :details_attributes => {:website => church.website})
            
          if(@newChurch.valid? && @newChurch.save)
            church.delete
            Preferences.applicationLogger("New Church Added to Main: #{church.name}, #{church.address}, #{church.city}, #{church.denomination}")
            flash[:notice] = "Successfully added #{@selectedChurches.count()} new #{'church'.pluralize(@selectedChurches.count())} to the main database"
          else
            flash[:notice] = @newChurch.errors.full_messages
          end
        end
      end
    end
    
    redirect_to administration_newChurches_path
  end
  
 #--------------------------- Web Options ------------------------------------
  
  def webOptions
    @denominations = Denomination.all
  end
  
  def clearCache
    Denomination.expire_all_cache
    flash[:notice] = "Cleared All Cache"
    redirect_to administration_webOptions_path
  end
  
  def addDenomination
    if(!params[:denomination].blank?)
      Denomination.create(:name => params[:denomination])
      flash[:notice] = "Added new Denomination for #{params[:denomination]}"
    end
    
    redirect_to administration_webOptions_path
  end
  
end
