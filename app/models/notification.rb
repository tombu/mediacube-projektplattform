class Notification < ActiveRecord::Base
  belongs_to :sender, :class_name => "User"
  belongs_to :receiver, :class_name => "User"
  belongs_to :project
  
  def categories
    self.project.categories.map { |c| c.label }
  end
end
