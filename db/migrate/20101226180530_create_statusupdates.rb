class CreateStatusupdates < ActiveRecord::Migration
  def self.up
    create_table :statusupdates do |t|
      t.text :content
      t.boolean :isPublic
      t.references :template_message, :user, :project
      t.timestamps
    end
  end

  def self.down
    drop_table :statusupdates
  end
end
