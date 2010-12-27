class User < ActiveRecord::Base
  has_and_belongs_to_many :projects
  has_many :statusupdates
  
  validates :course, :inclusion => { :in => %w( multimediaart multimediatechnology ) }
  validates :role, :inclusion => { :in => %w( student lectorer ) }
  validates :course, :role, :fhname, :allow_nil => true
  validates :mail, :email => true
  validates :name, :mail, :password, :presence => true
end
