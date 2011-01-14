class Category < ActiveRecord::Base
  attr_accessible :label, :projects, :project_ids
  
  has_and_belongs_to_many :projects
end
