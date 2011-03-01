class Notification < ActiveRecord::Base
  belongs_to :sender, :class_name => "User"
  belongs_to :receiver, :class_name => "User"
  belongs_to :project
  
  def categories
    @categories = Array.new
    self.project.categories.each do |c|
      @categories << c.label
    end
    @categories
  end
end
