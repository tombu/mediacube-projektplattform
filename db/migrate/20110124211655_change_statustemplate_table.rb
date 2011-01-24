class ChangeStatustemplateTable < ActiveRecord::Migration
  def self.up
    rename_table :statustemplates, :texttemplates
    rename_column :texttemplates, :template, :text
    change_column :texttemplates, :text, :text
  end

  def self.down
    change_column :texttemplates, :text, :string
    rename_column :texttemplates, :text, :template
    rename_table :texttemplates, :statustemplates
  end
end
