class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.integer :picture
      t.boolean :isInternal
      t.string :status
      t.boolean :isPublic
      t.string :link
      t.integer :owner_id 
      t.integer :currentStage

      t.timestamps
    end
    
    create_table :projects_users do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :role
      t.integer :job_id
    end
    
    create_table :categories_projects do |t|
      t.integer :project_id
      t.integer :category_id
    end
  end

  def self.down
    drop_table :projects
    drop_table :projects_users
  end
end
