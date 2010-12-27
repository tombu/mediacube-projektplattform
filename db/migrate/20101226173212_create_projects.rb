class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :title, :status, :link
      t.text :description
      t.integer :picture, :currentStage
      t.boolean :isInternal, :isPublic
      t.references :user
      t.timestamps
    end
    
    create_table :projects_users do |t|
      t.string :role
      t.references :project, :user, :job
    end
    
    create_table :categories_projects do |t|
      t.references :project, :category
    end
  end

  def self.down
    drop_table :projects, :projects_users, :categories_projects
  end
end