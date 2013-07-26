class Signup < ActiveRecord::Base
  attr_accessible :event_id, :user_id, :confirmed, :credits_earned

  before_create :set_default_credits

  belongs_to :user
  belongs_to :event

  def set_default_credits
    self.credits_earned = self.event.credits
  end

  def name
    self.event.title + ': ' + self.user.full_name
  end
end
