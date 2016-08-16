class ChangeColumnNameofFeed < ActiveRecord::Migration
  def change
    rename_column :feeds, :flight_no, :feed_content
    rename_column :feeds, :available, :reserved_column
  end
end
