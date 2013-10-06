class Attendance < ActiveRecord::Base
  attr_accessible :in_time, :out_time, :present, :meeting_id, :user_id

	belongs_to :user
	belongs_to :meeting

	def present_time
		self.out_time - self.in_time
	end
	def mandatory
		self.meeting.mandatory
	end
end
