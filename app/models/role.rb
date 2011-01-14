class Role < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
 # validates :role, :inclusion => { :in => %w( member leader owner ) }
end
