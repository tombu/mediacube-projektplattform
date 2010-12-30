class Role < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :job
  
 # validates :role, :inclusion => { :in => %w( member leader owner ) }
end
