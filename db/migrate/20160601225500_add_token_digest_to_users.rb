class AddTokenDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token_digest, :string
    
    add_index :users,  :email
  end
end
