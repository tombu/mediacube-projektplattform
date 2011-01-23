class Project < ActiveRecord::Base
  attr_accessible :title, :status, :link, :description, :picture, :category_ids, :job_ids, :role_ids, :roles
  
  has_and_belongs_to_many :categories
  has_many :jobs, :dependent => :destroy
  has_many :media
  has_many :images
  belongs_to :cover
  has_many :roles, :order => 'role DESC', :dependent => :destroy
  has_many :users, :through => :roles
  has_many :stages
  has_many :statusupdates

  def self.parse_status status
    @status_names = { "idea" => "Idee", "inprogress" => "In Arbeit", "finished" => "Abgeschlossen", "Idee" => "idea", "In Arbeit" => "inprogress", "Abgeschlossen" => "finished" }
    @status_names[status]
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


  def has_followers
    self.roles.where(:role => "follower" )
  end
  
  def has_members
    self.roles.where(:role => [ "owner", "leader", "member" ])
  end
end
