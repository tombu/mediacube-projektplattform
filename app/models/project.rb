class Project < ActiveRecord::Base
  attr_accessible :title, :status, :link, :description, :picture
  
  has_and_belongs_to_many :categories
  has_many :jobs
  has_many :media
  has_many :roles
  has_many :followers
  has_many :users, :through => :followers
  
  def self.search(search)
    if search
      find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
