class Meeting < ActiveRecord::Base
	#TODO: meetings have times???
  attr_accessible :description, :mandatory, :meeting_date

	scope :desc, order("meetings.created_at DESC")

	self.per_page = 10

	has_many :attendances, :dependent => :delete_all
	has_many :users, :through => :attendances
	validate :meeting_date, :presence => true
	def name
		'Meeting: ' + self.meeting_date.strftime('%A, %B %-d')
	end

	def day_of_the_week
		self.meeting_date.strftime('%A')
	end
        after_create do
                User.all.each do |user|
                        # new meeting; create attendances for all users
                        new_attend = Attendance.new(:user_id => user.id, :meeting_id => self.id)
                        unless new_attend.save then return "ERROR: could not create new attendance" end
                end
        end
	before_destroy { |record| Attendance.destroy_all "meeting_id=#{record.id}" }
end
