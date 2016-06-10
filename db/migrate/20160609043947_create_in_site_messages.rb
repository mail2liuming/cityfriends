class CreateInSiteMessages < ActiveRecord::Migration
  def change
    create_table :in_site_messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :msg_content
      t.integer :status
      t.integer :msg_type

      t.timestamps null: false
    end
    
    add_index :in_site_messages, :sender_id
    add_index :in_site_messages, :receiver_id
  end
end
