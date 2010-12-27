class Project < ActiveRecord::Base
  validates :status, :inclusion => { :in => %w( idea inprogress completed ) }
end
