class AddColumnStatementToTableUser < ActiveRecord::Migration
  def self.up
    add_column :users, :statement, :text
  end

  def self.down
    remove_column :users, :statement
  end
end
