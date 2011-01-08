class Project < ActiveRecord::Base
  attr_accessible :title, :status, :link, :description, :picture
  
  has_and_belongs_to_many :categories
  has_many :jobs
  has_many :media
  has_many :images
  has_many :roles
  has_many :followers
  has_many :users, :through => :followers
  has_many :stages
  belongs_to :cover
  
  def self.search(search)
    if search
      find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
  
  def cover_url
    if self.cover.nil?
      "/images/default_project_cover.jpg"
    else
      self.cover.asset.url(:cover)
    end
  end
  
  def icon_url
    if self.cover.nil?
      "/images/default_project_icon.jpg"
    else
      self.cover.asset.url(:small)
    end
  end
end
