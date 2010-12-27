class CreateStatusupdates < ActiveRecord::Migration
  def self.up
    create_table :statusupdates do |t|
      t.text :content
      t.boolean :isPublic
      t.integer :template_message_id
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :statusupdates
  end
end
