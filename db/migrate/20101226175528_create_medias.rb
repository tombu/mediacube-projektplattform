class CreateMedias < ActiveRecord::Migration
  def self.up
    create_table :medias do |t|
      t.string :label, :link
      t.references :project, :statusupdate
      t.timestamps
    end
  end

  def self.down
    drop_table :medias
  end
end
