class ChangeColPictureInProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.remove :picture
      t.integer :cover_id
    end
  end

  def self.down
    change_table :projects do |t|
      t.string :picture
      t.remove :cover_id
    end
  end
end
