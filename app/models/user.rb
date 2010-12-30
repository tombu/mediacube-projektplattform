class User < ActiveRecord::Base
  has_and_belongs_to_many :projects, :join_table => :followers
  has_many :statusupdates
  has_many :roles
  has_many :projects, :through => :roles

#  validates :course, :inclusion => { :in => %w( multimediaart multimediatechnology ) }
#  validates :role, :inclusion => { :in => %w( student lectorer ) }
#  validates :course, :role, :fhname, :allow_nil => true
#  validates :mail, :email => true
#  validates :name, :mail, :password, :presence => true
end
