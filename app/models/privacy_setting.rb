class PrivacySetting < ActiveRecord::Base
  attr_accessible :show_update
  
  belongs_to :project
end
