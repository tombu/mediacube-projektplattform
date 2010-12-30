class Job < ActiveRecord::Base
  belongs_to :project
  has_one :role
end
