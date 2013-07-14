class Signup < ActiveRecord::Base
  attr_accessible :event_id, :user_id, :confirmed

  belongs_to :user
  belongs_to :event
end
