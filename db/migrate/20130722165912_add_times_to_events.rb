class AddTimesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :start_time, :time, :default => Time.now
    add_column :events, :end_time, :time, :default => Time.now + 2.hours
  end
end
