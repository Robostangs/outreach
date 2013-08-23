class RemoveTimesFromMeetings < ActiveRecord::Migration
	def change
		change_table :meetings do |t|
			t.remove :start_time, :end_time
		end
	end
end
