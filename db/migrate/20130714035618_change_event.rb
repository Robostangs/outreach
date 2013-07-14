class ChangeEvent < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.rename :signup_expire, :deadline
    end
  end
end
