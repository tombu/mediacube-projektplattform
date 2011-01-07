class AddColToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :currentstage, :integer
  end

  def self.down
    remove_column :projects, :currentstage
  end
end
