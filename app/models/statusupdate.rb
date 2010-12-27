class Statusupdate < ActiveRecord::Base
  belongs_to :project, :template_message, :user
  has_many :medias
end
