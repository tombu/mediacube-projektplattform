class ChangeUserTable < ActiveRecord::Migration
  def self.up
    remove_column :users, :mail
    remove_column :users, :password
  end

  def self.down
    add_column :users, :mail, :string
    add_column :users, :password, :string
  end
end
