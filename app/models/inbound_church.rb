class InboundChurch < ActiveRecord::Base
  acts_as_gmappable :process_geocoding => true, :check_process => true
  
  # Pagination limit
  self.per_page = 50
  
  before_save :reverse_geocode

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      # populate your model
      obj.address = geo.address.split(",")[0]
      obj.city    = geo.city
      obj.state   = geo.state_code
      obj.zipCode = geo.postal_code
    end
  end
  
  def gmaps4rails_address
    #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.latitude}, #{self.longitude}"
  end
  
  def gmaps4rails_infowindow
    "<h3>#{self.name}</h3>" << "<h4>#{self.address}</h4>" << "<h4>#{self.city}, #{self.state}, #{self.zipCode}</h4>"
  end
  
  scope :matches, ->(foundChurch) { where(:googleId => foundChurch[:full_data]['id']) }
  
end
