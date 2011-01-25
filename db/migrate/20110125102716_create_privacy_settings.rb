class CreatePrivacySettings < ActiveRecord::Migration
  def self.up
    create_table :privacy_settings do |t|
      t.boolean :show_update
      t.boolean :show_update_media
      t.boolean :show_update_edit
      t.boolean :show_update_jobs
      t.boolean :show_update_status
      t.boolean :show_update_user
      t.boolean :show_update_post
      t.references :project
      
      t.timestamps
    end
  end

  def self.down
    drop_table :privacy_settings
  end
end
