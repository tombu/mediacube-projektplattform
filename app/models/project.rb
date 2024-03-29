class Project < ActiveRecord::Base
  attr_accessible :title, :status, :link, :description, :picture, :category_ids, :job_ids, :role_ids, :roles, :privace_setting_id, :show_update, :stage_ids, :isPublic
  
  
  has_and_belongs_to_many :categories
  has_many :jobs, :dependent => :destroy
  accepts_nested_attributes_for :jobs, :allow_destroy => true
  has_many :media
  has_many :images
  belongs_to :cover
  has_many :roles, :order => 'role DESC', :dependent => :destroy
  has_many :users, :through => :roles
  has_many :stages, :dependent => :destroy
  has_many :statusupdates
  has_one :privacy_setting

  after_update :post_statusupdate

  scope :is_public, where("isPublic = ?", true)
  scope :category, lambda { |category_label|
    joins(:categories).
    where(:categories => {:label => category_label}) 
  }
  scope :status, lambda { |status| 
    where(:status=>parse_status(status))
  }
  scope :sorted, order('created_at DESC')
  
  def self.parse_status status
    @status_names = { 
      "idea"          => "Idee", 
      "inprogress"    => "In Arbeit", 
      "finished"      => "Abgeschlossen", 
      "Idee"          => "idea", 
      "In Arbeit"     => "inprogress", 
      "Abgeschlossen" => "finished" 
    }
    @status_names[status]
  end
  
  # filter projects by category or status
  def self.filter_projects category, status
    if !category.nil? && !status.nil?
      Project.category(category).status(status)
    elsif !category.nil?
      Project.category(category)
    elsif !status.nil?
      Project.status(status)
    else 
      Project
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

  def owner
    User.joins(:roles).where(:roles => { :role => "owner", :project_id => self.id }).first
  end
  
  def team owner=false
    if owner
      User.joins(:roles).where(:roles => { :role => ["member", "leader", "owner"], :project_id => self.id })
    else
      User.joins(:roles).where(:roles => { :role => ["member", "leader"], :project_id => self.id })
    end
  end
  
  def followers
    User.joins(:roles).where(:roles => { :role => "follower", :project_id => self.id })
  end

  def has_followers
    self.roles.where(:role => "follower" )
  end
  
  def has_members
    self.roles.where(:role => [ "owner", "leader", "member" ])
  end
  
protected
  def post_statusupdate
    if self.title_changed? || self.description_changed?
      self.statusupdates.create(
        :content => Texttemplate.substitute(:project_edit), :isPublic => true, 
        :user => nil, :html_tmpl_key => "EDIT")
    elsif self.status_changed?
      self.statusupdates.create(
        :content => Texttemplate.substitute(:project_status_edit, {"#status" => Project.parse_status(status)}), 
        :isPublic => true, :user => nil, :html_tmpl_key => "STATUS")
    end
  end
end