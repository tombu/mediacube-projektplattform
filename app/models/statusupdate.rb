class Statusupdate < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :media
  
  scope :sorted, order('created_at DESC')
end
