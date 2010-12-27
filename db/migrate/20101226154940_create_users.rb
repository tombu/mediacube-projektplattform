class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :mail, :telephone, :password, :web, :avatar, :fhname, :course, :role
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
