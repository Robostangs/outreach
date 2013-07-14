class CreateSignups < ActiveRecord::Migration
  def change
    change_table :signups do |t|
      t.boolean :confirmed, :default => false

      t.timestamps
    end
  end
end
