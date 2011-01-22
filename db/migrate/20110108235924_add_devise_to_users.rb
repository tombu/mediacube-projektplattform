class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    
    change_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.confirmable
      
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable
    end

  end

  def self.down
    change_table(:users) do |t|
      t.remove :email, :encrypted_password, :password_salt, :reset_password_token
      t.remove :remember_token, :remember_created_at
      t.remove :sign_in_count, :current_sign_in_at, :last_sign_in_at
      t.remove :current_sign_in_ip, :last_sign_in_ip
      t.remove :confirmation_token, :confirmed_at, :confirmation_sent_at
    end
  end
end
