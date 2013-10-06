class Event < ActiveRecord::Base
  attr_accessible :description, :event_date, :max_slots, :deadline, :title, :credits, :start_time, :end_time

  scope :desc, order("events.created_at DESC")
  scope :active, lambda { where("deadline > ?", Time.now) }

  self.per_page = 10

  has_many :signups
  has_many :users, :through => :signups

  def full?
    self.signups.count >= self.max_slots
  end

  def slots_left
    self.max_slots - self.signups.count
  end

	def nice_start_time
		self.start_time.strftime("%l:%M %P")
	end

	def nice_end_time
		self.end_time.strftime("%l:%M %P")
	end
end
