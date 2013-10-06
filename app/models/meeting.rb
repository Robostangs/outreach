class Meeting < ActiveRecord::Base
	#TODO: meetings have times???
  attr_accessible :description, :mandatory, :meeting_date

	scope :desc, order("meetings.created_at DESC")

	self.per_page = 10

	has_many :attendances, :dependent => :delete_all
	has_many :users, :through => :attendances

	def name
		'Meeting: ' + self.meeting_date.strftime('%A, %B %-d')
	end

	def day_of_the_week
		self.meeting_date.strftime('%A')
	end
end
