class Event < ActiveRecord::Base
  attr_accessible :description, :event_date, :max_slots, :signup_expire, :title, :credits

  scope :desc, order("events.created_at DESC")
  scope :active, lambda { where("signup_expire > ?", Time.now) }

  self.per_page = 10

  has_many :signups
  has_many :users, :through => :signups

  def full?
    self.signups.count >= self.max_slots
  end
end
