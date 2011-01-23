class AddColumnHtmlTmplKeyToStatusUpdates < ActiveRecord::Migration
  def self.up
    add_column :statusupdates, :html_tmpl_key, :string
  end

  def self.down
    remove_column :statusupdates, :html_tmpl_key
  end
end
