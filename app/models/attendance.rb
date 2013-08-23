class Attendance < ActiveRecord::Base
  attr_accessible :in_time, :out_time, :present, :meeting_id, :event_id

	belongs_to :user
	belongs_to :event

	def present_time
		self.out_time - self.in_time
	end
end
