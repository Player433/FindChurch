
Geocoder.configure(
  # geocoding service
  lookup: :google,

  # geocoding service request timeout (in seconds)
  timeout: 3,
  
)
# to use an API key:
#Geocoder::Configuration.api_key = Preferences.apiKey

# use HTTPS for geocoding service connections: (may be needed when SSL is used)
#Geocoder::Configuration.use_https = true
