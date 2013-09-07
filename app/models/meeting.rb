class Meeting < ActiveRecord::Base
  attr_accessible :description, :mandatory, :meeting_date

	scope :desc, order("meetings.created_at DESC")

	self.per_page = 10

	has_many :attendances
	has_many :users, :through => :attendances
end
