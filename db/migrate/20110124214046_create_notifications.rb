class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.text :content
      t.references :sender
      t.references :receiver
      t.references :project
      t.boolean :isNew
      t.string :html_tmpl_key
      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
