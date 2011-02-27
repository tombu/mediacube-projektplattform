class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable :confirmable,
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :telephone, :statement, :web, :email, :password, :password_confirmation, :remember_me
  
  validates_presence_of :email
  validates_uniqueness_of :email
  
  has_many :statusupdates
  has_many :roles
  has_many :projects, :through => :roles
  has_many :notifications

#  validates :course, :inclusion => { :in => %w( multimediaart multimediatechnology ) }
#  validates :role, :inclusion => { :in => %w( student lectorer ) }
#  validates :course, :role, :fhname, :allow_nil => true
#  validates :mail, :email => true
#  validates :name, :mail, :password, :presence => true
  
  @current_role  
  
  def current_role=(roles)
    @current_role = roles
  end

  def role_symbols
    (@current_role || []).map do |role| 
      role.role.to_sym
    end
  end
  
  def can_apply? project
    Notification.where(:project_id => project.id, :sender_id => self.id, :html_tmpl_key => "DECISION_TO_OWNER").any? || Notification.where(:project_id => project.id, :receiver_id => self.id, :html_tmpl_key => "DECISION_TO_USER").any? ? false : true
  end
  
  def notifications
    Notification.where(:receiver_id => self.id).order('created_at DESC')
  end
  
  def running_projects
    Project.joins(:roles).where(:roles => { :role => [ "owner", "leader", "member" ], :user_id => self.id }, :projects => { :status => [ "idea", "inprogress" ] })
  end
  
  def finished_projects
    Project.joins(:roles).where(:roles => { :user_id => self.id }, :projects => { :status => "finished" })
  end
  
  def involved_projects
    Project.joins(:roles).where(:roles => { :role => [ "owner", "leader", "member" ], :user_id => self.id })
  end
  
  def following_projects
    Project.joins(:roles).where(:roles => { :role => "follower", :user_id => self.id })
  end
  
  def is_following
    self.roles.where(:role => "follower")
  end
  
  def is_involved
    self.roles.where(:role => [ "owner", "leader", "member" ])
  end
  
  def does_follow_project? project
    project.followers.include?(self)
  end

  def self.count_unread_notifications user
    Notification.where(:receiver_id=>user.id, :isNew=>true).count
  end
end
