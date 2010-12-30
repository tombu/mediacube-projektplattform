class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :role
      t.references :project
      t.references :user
      t.references :job
    end
  end

  def self.down
    drop_table :roles
  end
end