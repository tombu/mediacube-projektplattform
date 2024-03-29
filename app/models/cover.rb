class Cover < Medium
  has_one :project
  
  has_attached_file :asset, :whiny => false,
    :styles => { 
      :cover => "230x130#",
      :small => "40x40#" },
    :url => "/media/projects/images/:style/:id_:filename",
    :path => ":rails_root/public/media/projects/images/:style/:id_:filename"
    
  before_create :randomize_file_name
  
end