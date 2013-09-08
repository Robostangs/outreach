require 'csv'

class CsvDb
	class << self 
		def import_meeting(csv_data)
			# TODO: check for duplicate upload; handle
			csv_file = csv_data.read
			csv_array = CSV.parse(csv_file)
			new_meeting = Meeting.new
			csv_cols = Hash.new
			messages = ""

			csv_array.each_with_index do |row, i|
				if i == 0 
					# column headers row
					row.each_with_index do |col, t|
						# identify relevant database columns
						if col.upcase.include? 'ID' then csv_cols[:school_id] = t
						elsif col.upcase.include? 'IN' then csv_cols[:in_time] = t
						elsif col.upcase.include? 'OUT' then csv_cols[:out_time] = t
						elsif col.upcase.include? 'DATE' then csv_cols[:date] = t
						end
					end
				elsif i == 1
					# set meeting date
					new_meeting.meeting_date = Date.strptime(row[csv_cols[:date]], '%m/%d/%Y')
					unless new_meeting.save then return "ERROR: could not save new meeting" end

					User.all.each do |user|
						# new meeting; create attendances for all users
						new_attend = Attendance.new(:user_id => user.id, :meeting_id => new_meeting.id)
						unless new_attend.save then return "ERROR: could not create new attendance" end
					end

					# this row contains user data as well, process
					user = User.find_by_school_id(row[csv_cols[:school_id]])
					unless user == nil 
						attend = user.attendances.find_by_meeting_id(new_meeting.id)
						attend.present = true
						attend.in_time = Time.zone.parse(row[csv_cols[:in_time]])
						attend.out_time = Time.zone.parse(row[csv_cols[:out_time]])
						unless attend.save then return "ERROR: could not save attendance from row #{i + 1} 2" end
					else 
						messages << "could not find user with id #{row[csv_cols[:school_id]]}, row #{i + 1}"
					end
				else
					# process user data
					user = User.find_by_school_id(row[csv_cols[:school_id]])
					unless user == nil 
						attend = user.attendances.find_by_meeting_id(new_meeting.id)
						attend.present = true
						attend.in_time = Time.zone.parse(row[csv_cols[:in_time]])
						attend.out_time = Time.zone.parse(row[csv_cols[:out_time]])
						unless attend.save then return "ERROR: could not save attendance from row #{i + 1}" end
					else 
						messages << "could not find user with id #{row[csv_cols[:school_id]]}, row #{i + 1}"
					end
				end
			end
			messages
		end
	end
end

