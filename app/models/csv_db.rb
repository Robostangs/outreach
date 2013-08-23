require 'csv'

# WARNING: massively untested
class CsvDb
	class << self 
		def import_meeting(csv_data)
			# TODO: check for duplicate upload; handle
			csv_file = csv_data.read
			new_meeting = Meeting.new
			iterator = 0
			csv_cols = Hash.new

			CSV.parse(csv_file) do |row|
				if iterator == 0 
					# column headers row
					row.each_with_index do |col, i|
						# identify relevant database columns
						if col.upcase.include? 'ID' then csv_cols.add{ :school_id => i } 
						elsif col.upcase.include? 'IN TIME' then csv_cols.add { :in_time => i }
						elsif col.upcase.include? 'OUT TIME' then csv_cols.add { :out_time => i }
						elsif col.upcase.include? 'DATE' then csv_cols.add { :date => i }
						end
					end

					iterator += 1
				elsif iterator == 1
					# set meeting date
					new_meeting.send "meeting_date=", row[csv_cols[:date]]
					new_meeting.save

					User.all.each do |user|
						# new meeting; create attendances for all users
						new_attend = Attendance.new(:user_id => user.id, :meeting_id => new_meeting.id)
						new_attend.save
					end

					# this row contains user data as well, process
					user = User.find_by school_id: row[csv_cols[:school_id]]
					attend = user.attendances.find_by meeting_id: new_meeting.id
					attend.present = true
					attend.in_time = Time.zone.parse(row[csv_cols[:in_time]])
					attend.out_time = Time.zone.parse(row[csv_cols[:out_time]])

					iterator += 1
				else
					# process user data
					user = User.find_by school_id: row[csv_cols[:school_id]]
					attend = user.attendances.find_by meeting_id: new_meeting.id
					attend.present = true
					attend.in_time = Time.zone.parse(row[csv_cols[:in_time]])
					attend.out_time = Time.zone.parse(row[csv_cols[:out_time]])
				end
			end
		end
	end
end

