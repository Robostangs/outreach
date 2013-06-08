class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, :null => false
      t.string :description, :null => false
      t.integer :max_slots, :default => 5
      t.date :event_date, :default => Time.now + 2.weeks
      t.date :signup_expire, :default => Time.now + 1.week
      t.float :credits, :default => 2

      t.timestamps
    end
  end
end
