module Preferences
  @@actionLogger = Logger.new("UserActionLogs")
  @@applicationLogger = Logger.new("ApplicationLogs")
  @@jobLogger = Logger.new("CronJobLogs")
  
  def self.denominations
    @@denominations = Denomination.all_cached
  end
  
  def self.actionLogger(message)
    @@actionLogger.info message
  end
  
  def self.applicationLogger(message)
    @@applicationLogger.info message
  end
  
  def self.jobLogger(message)
    @@jobLogger.info message
  end
  
  def self.defaultLocation
    Rails.cache.fetch("default_locations") do
      Church.near("63376", 20).to_gmaps4rails do |church, marker|
        marker.title "#{church.name}"
        marker.picture({:picture => "/mapIcons/#{church.denomination || "NonDenomination"}.png", :width => 32, :height => 32})
      end
    end
  end
  
  def self.apiKey
    "AIzaSyDyNnSdfBHMgAfFA515Yde1OTFxb52FXWU"
  end
  
end