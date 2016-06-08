class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.integer :user_id
      t.integer :feed_type
      t.string :flight_no
      
      t.string :start_place
      t.datetime :start_time
      t.string :end_place
      t.datetime :end_time
      
      t.string :available
      t.integer :up

      t.timestamps null: false
    end
    add_index :feeds, :user_id
  end
end
