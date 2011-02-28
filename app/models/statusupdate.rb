class Statusupdate < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :media
  
  scope :dashboard, lambda { |user| joins(:project => {:roles => :user}).where(:users => {:id => user.id}).order('created_at DESC') }
  
end
