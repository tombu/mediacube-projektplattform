class DropTableFollowers < ActiveRecord::Migration
  def self.up
    drop_table :followers
  end
  
  def self.down
    create_table :followers do |t|
      t.references :project
      t.references :user
    end
  end

end
