class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name, :school_id

	before_create :correct_school_id

	validates :school_id, :uniqueness => true

  has_many :signups
  has_many :events, :through => :signups
	has_many :attendances
	has_many :meetings, :through => :attendances

	def correct_school_id
		if self.school_id[0] != 'S' then self.school_id = 'S' + self.school_id end
	end

  def full_name
    self.first_name + " " + self.last_name
  end

	def meeting_attendance
		present_at = 0
		self.attendances.each { |attend| if attend.present then present_at += 1 end }
		(present_at / self.attendances.count.to_f) * 100
	end

	def missed_mandatory_meetings
		missed = 0
		self.attendances.each { |attend| if attend.mandatory and not attend.present then missed += 1 end }
		missed
	end
end
