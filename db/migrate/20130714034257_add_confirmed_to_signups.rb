class AddConfirmedToSignups < ActiveRecord::Migration
  def change
    add_column :signups, :confirmed, :boolean, :default => false
  end
end
