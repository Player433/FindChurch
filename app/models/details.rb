class Details < ActiveRecord::Base
  belongs_to :church, dependent: :destroy, autosave: true
end
