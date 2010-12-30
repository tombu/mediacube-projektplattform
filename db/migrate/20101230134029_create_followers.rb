class CreateFollowers < ActiveRecord::Migration
  def self.up
    create_table :followers do |t|
      t.references :project
      t.references :user
    end
  end

  def self.down
    drop_table :followers
  end
end
