class Medium < ActiveRecord::Base
  belongs_to :project
  has_one :image
  
  has_attached_file :asset, 
    :url => "/media/projects/images/:style/:id_:filename",
    :path => ":rails_root/public/media/projects/images/:style/:id_:filename"
  
  protected

    def randomize_file_name
      extension = File.extname(asset_file_name).downcase
      self.asset.instance_write(:file_name, "#{ActiveSupport::SecureRandom.hex(16)}#{extension}")
    end
#  Paperclip.interpolates :asset_type do |attachment, class|
#    if attachment.instance.class.to_s.underscore.pluralize == "covers" 
#    || attachment.instance.class.to_s.underscore.pluralize == "images" 
#      "images"
#  end
end
