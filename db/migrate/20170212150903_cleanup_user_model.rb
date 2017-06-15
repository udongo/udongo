class CleanupUserModel < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :password
    remove_column :users, :display_name

    change_column :users, :first_name, :string, after: 'id'
    change_column :users, :last_name, :string, after: 'first_name'
    change_column :users, :email, :string, after: 'last_name'

    add_column :users, :login_count, :integer, after: 'email'
    add_column :users, :current_login_ip, :string, after: 'login_count'
    add_column :users, :last_login_ip, :string, after: 'current_login_ip'
    add_column :users, :current_login_at, :datetime, after: 'last_login_ip'
    add_column :users, :last_login_at, :datetime, after: 'current_login_at'
    add_column :users, :reset_password_token, :string, after: 'last_login_at'
    add_column :users, :reset_password_sent_at, :datetime, after: 'reset_password_token'

    add_index :users, :reset_password_token
  end
end
