class AddStatusToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :status, :integer
  end
end
