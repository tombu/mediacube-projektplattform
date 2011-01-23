class CreateStatusupdates < ActiveRecord::Migration
  def self.up
    create_table :statusupdates do |t|
      t.string :content
      t.boolean :isPublic
      t.references :user
      t.references :project

      t.timestamps
    end
  end

  def self.down
    drop_table :statusupdates
  end
end
