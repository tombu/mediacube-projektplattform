class User < ActiveRecord::Base
  has_many :statusupdates
  has_many :roles
  has_many :followers
  has_many :projects, :through => :followers

#  validates :course, :inclusion => { :in => %w( multimediaart multimediatechnology ) }
#  validates :role, :inclusion => { :in => %w( student lectorer ) }
#  validates :course, :role, :fhname, :allow_nil => true
#  validates :mail, :email => true
#  validates :name, :mail, :password, :presence => true
end
