class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable :confirmable,
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :statusupdates
  has_many :roles
  has_many :projects, :through => :roles

#  validates :course, :inclusion => { :in => %w( multimediaart multimediatechnology ) }
#  validates :role, :inclusion => { :in => %w( student lectorer ) }
#  validates :course, :role, :fhname, :allow_nil => true
#  validates :mail, :email => true
#  validates :name, :mail, :password, :presence => true
  
  @current_role  
  
  def current_role=(roles)
    @current_role = roles
  end
  
  def role
    @current_role.inspect
  end
  
  def role_symbols
    (@current_role || []).map do |role| 
      role.role.to_sym
    end
  end
  
  def is_following
    self.roles.where(:role => "follower")
  end
  
  def is_involved
    self.roles.where(:role => [ "owner", "leader", "member" ])
  end

end
