class Denomination < ActiveRecord::Base
  
  def self.all_cached
    Rails.cache.fetch('Denomination.all') { Denomination.pluck(:name) }
  end
  
  def self.expire_all_cache
    Rails.cache.delete('Denomination.all')
  end
  
end
