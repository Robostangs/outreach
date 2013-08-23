class Meeting < ActiveRecord::Base
  attr_accessible :description, :mandatory, :meeting_date

	has_many :attendances
	has_many :users, :through => :attendances
end
