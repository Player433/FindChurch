json.array!(@inbound_churches) do |inbound_church|
  json.extract! inbound_church, :name, :description, :address, :state, :city, :zipCode, :denomination, :latitude, :longitude, :gmaps
  json.url inbound_church_url(inbound_church, format: :json)
end
