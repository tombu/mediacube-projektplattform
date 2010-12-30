class Project < ActiveRecord::Base
  attr_accessible :title, :status, :link, :description, :picture
  
  has_and_belongs_to_many :categories
  has_many :jobs
  has_many :roles
  has_many :users, :through => :roles
end
