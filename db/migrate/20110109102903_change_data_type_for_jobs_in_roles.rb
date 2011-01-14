class ChangeDataTypeForJobsInRoles < ActiveRecord::Migration
  def self.up
    change_table :roles do |t|
      t.change :job_id, :string
    end
    rename_column :roles, :job_id, :job
  end

  def self.down
    change_table :roles do |t|
      t.change :job_id, :integer
    end
    rename_column :roles, :job, :job_id
  end
end
