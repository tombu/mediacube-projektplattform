class Statusupdate < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :media
  
end
