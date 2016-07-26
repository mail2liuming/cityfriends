class AddExateTimeToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :exate_time, :datetime
  end
end
