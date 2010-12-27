class DeviseCreateLdapUsers < ActiveRecord::Migration
  def self.up
    create_table(:ldap_users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    add_index :ldap_users, :email,                :unique => true
    add_index :ldap_users, :reset_password_token, :unique => true
    # add_index :ldap_users, :confirmation_token,   :unique => true
    # add_index :ldap_users, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :ldap_users
  end
end
