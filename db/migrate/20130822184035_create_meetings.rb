class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.date :meeting_date, :null => false
      t.time :start_time, :null => false
      t.time :end_time, :null => false
      t.string :description, :default => "General meeting"
      t.boolean :mandatory, :default => false

      t.timestamps
    end
  end
end
