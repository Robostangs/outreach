class AddCreditsEarnedToSignups < ActiveRecord::Migration
  def change
    add_column :signups, :credits_earned, :float
  end
end
