class CreateStatustemplates < ActiveRecord::Migration
  def self.up
    create_table :statustemplates do |t|
      t.string :key
      t.string :template
      t.timestamps
    end
  end

  def self.down
    drop_table :statustemplates
  end
end
