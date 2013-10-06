ActiveAdmin.register Meeting do
	menu :priority => 6 
	filter :meeting_date
	filter :mandatory

	index do 
		column "Date", :sortable => :meeting_date do |meeting|
			meeting.meeting_date.strftime("%A, %B #{meeting.meeting_date.day.ordinalize}, %Y")
		end
		column :description
		column "Mandatory", :sortable => :mandatory do |meeting|
			if meeting.mandatory then "Yes"
			else "No"
			end
		end
                column :number_of_attendees do |meeting|
                        count = 0
                        meeting.attendances.each { |attend| if attend.present then count += 1 end }
                        count
		end
		default_actions
	end

	show do |meeting|
		attributes_table do 
			row :meeting_date do
	                        meeting.meeting_date.strftime("%A, %B #{meeting.meeting_date.day.ordinalize}, %Y")
			end
			row :description
			row :mandatory do
				if meeting.mandatory then "Yes"
				else "No"
				end
			end
			row :number_of_attendees do
				count = 0
				meeting.attendances.each { |attend| if attend.present then count += 1 end }
				count
			end
			row :members_attended do
                                people = ""
				meeting.attendances.each { |attend| if attend.present then people = attend.user.full_name + "<br />" + people end }
				people.html_safe
			end
		end
	end

	action_item do
		link_to 'Upload Attendance', :action => 'upload_attend'
	end

	collection_action :upload_attend do
		render "admin/meetings/upload_attend"
	end

	collection_action :import_attend, :method => :post do
		error = CsvDb.import_meeting(params[:dump][:file])
		unless error == nil || error == ''
			flash[:error] = error
			redirect_to :action => :index
		else
			redirect_to :action => :index, :notice => "Upload successful." 
		end
	end
end
