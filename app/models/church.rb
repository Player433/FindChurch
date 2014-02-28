class Church < ActiveRecord::Base
  has_one :details, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :details
  
  validates :name, :denomination, :latitude, :longitude, :googleId, presence: true
  
  acts_as_gmappable :process_geocoding => false
  geocoded_by :gmaps4rails_address
  
  # Determines Pagination limit.
  self.per_page = 20

  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address}, #{self.city}, #{self.zipCode}" 
  end
  
  def gmaps4rails_infowindow
    "<h3>#{self.name}</h3>" << "<h4>#{self.address}</h4>" << "<h4>#{self.city}, #{self.state}, #{self.zipCode}</h4>"
  end
  
  scope :matches, ->(foundChurch) { where(:googleId => foundChurch[:full_data]['id']) }
  
end
