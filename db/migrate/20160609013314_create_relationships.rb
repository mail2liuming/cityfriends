class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :positive_user_id
      t.integer :status

      t.timestamps null: false
    end
    add_index :relationships ,:user_id
    add_index :relationships ,:positive_user_id
    add_index :relationships,[:user_id,:positive_user_id],unique:true
  end
end
