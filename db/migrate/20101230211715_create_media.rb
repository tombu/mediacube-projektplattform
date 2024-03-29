class CreateMedia < ActiveRecord::Migration
  def self.up
    create_table :media do |t|
      t.string :label, :link
      t.references :project
      t.references :statusupdate
      
      t.timestamps
    end
  end

  def self.down
    drop_table :media
  end
end
