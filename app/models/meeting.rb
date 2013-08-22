class Meeting < ActiveRecord::Base
  attr_accessible :description, :end_time, :mandatory, :meeting_date, :start_time
	has_many :users
end
