class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :title
      t.string :status
      t.string :link
      t.text :description
      t.string :picture
      t.boolean :isInternal
      t.boolean :isPublic

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
