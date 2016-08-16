class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.integer :user_id
      t.integer :feed_id
      t.integer :calendar_type
      t.datetime :exact_time

      t.timestamps null: false
    end
    
    add_index :calendars, :user_id
    add_index :calendars, :feed_id
  end
end
