class ChangeUserSchoolIdToString < ActiveRecord::Migration
	def change
		change_table :users do |t|
			t.change :school_id, :string
		end
	end
end
