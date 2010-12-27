class CreateTemplateMessages < ActiveRecord::Migration
  def self.up
    create_table :template_messages do |t|
      t.string :message

      t.timestamps
    end
  end

  def self.down
    drop_table :template_messages
  end
end
