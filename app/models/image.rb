class Image < Medium

  has_attached_file :asset, :whiny => false,
    :styles => { 
      :large => "130x130#",
      :medium => "90x90#"
    },
    :url => "/media/projects/images/:style/:id_:filename",
    :path => ":rails_root/public/media/projects/images/:style/:id_:filename"
    
  before_create :randomize_file_name
end