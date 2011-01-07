class Medium < ActiveRecord::Base
  belongs_to :project
  
  has_attached_file :asset, :whiny => false,
    :styles => { 
      :cover => "230x130#",
      :large => "130x130#",
      :medium => "90x90#",
      :small => "40x40#" },
    :url => "/media/projects/:id_:style_:basename.:extension",
    :path => ":rails_root/public/media/projects/:id_:style_:basename.:extension"
end
