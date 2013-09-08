ActiveAdmin.register Meeting do
	config.clear_action_items!

	index do 
		column :meeting_date
		column :day_of_the_week
=begin
		column "Day of the Week" do |meeting|
			meeting.day_of_the_week
		end
=end
		column :description
		column "Mandatory?", :sortable => :mandatory do |meeting|
			if meeting.mandatory then "Yes"
			else "No"
			end
		end
		default_actions
	end

	show do |meeting|
		attributes_table do 
			row :meeting_date
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
		end
	end


	action_item :only => :index do
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
