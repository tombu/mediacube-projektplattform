class CategoriesProjects < ActiveRecord::Migration
  def self.up
    create_table :categories_projects, :id => false do |t|
      t.references :category
      t.references :project
    end
  end

  def self.down
    drop_table :categories_projects
  end
end
