class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :mail
      t.string :telephone
      t.string :password
      t.string :web
      t.string :avatar
      t.string :fhname
      t.string :course
      t.string :role

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
