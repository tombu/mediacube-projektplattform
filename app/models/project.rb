class Project < ActiveRecord::Base
  has_many :stages, :medias, :statusupdates, :jobs
  has_and_belongs_to_many :categories, :users
  
  validates :status, :inclusion => { :in => %w( idea inprogress completed ) }
end
