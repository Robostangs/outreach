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
	validates :email, :password, :password_confirmation, :first_name, :last_name, :school_id, :presence => true
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
		(present_at / meetings.count.to_f) * 100
	end

        def meetings_attended
                present_at = 0
                self.attendances.each { |attend| if attend.present then present_at += 1 end }
                attended = present_at.to_s + "/" + sprintf("%g", meetings.count.to_f).to_s
		attended
        end

	def missed_mandatory_meetings
		missed = 0
		self.attendances.each { |attend| if attend.mandatory and not attend.present then missed += 1 end }
		missed
	end
	def credits
		confirmed_credits = 0
		self.signups.each do |signup|
			if signup.confirmed then
			confirmed_credits += signup.credits_earned
			end
		end
		confirmed_credits
	end	
	after_create do
		Meeting.all.each do |meeting|
			# new meeting; create attendances for all users
			new_attend = Attendance.new(:user_id => self.id, :meeting_id => meeting.id)
			unless new_attend.save then return "ERROR: could not create new attendance" end
		end 
	end
	before_destroy { |record| Signup.destroy_all "user_id=#{record.id}" }
	before_destroy { |record| Attendance.destroy_all "user_id=#{record.id}" }
end
