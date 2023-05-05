class AddJtiToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :jti, :string, null: false
    add_index :accounts, :jti, unique:  true 
    #Ex:- add_index("admin_users", "username")
  end
end
