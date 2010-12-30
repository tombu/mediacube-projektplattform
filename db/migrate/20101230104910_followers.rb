class Followers < ActiveRecord::Migration
  def self.up
    create_table :followers, :id => false do |t|
      t.references :project
      t.references :user
    end
  end

  def self.down
    drop_table :followers
  end
end
