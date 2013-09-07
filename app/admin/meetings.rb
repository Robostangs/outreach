ActiveAdmin.register Meeting do
	config.clear_action_items!

	action_item :only => :index do
		link_to 'Upload Attendance', :action => 'upload_attend'
	end

	collection_action :upload_attend do
		# create app/views/admin/meetings/upload_attend.html.erb
		render "admin/meetings/upload_attend"
	end

	collection_action :import_attend do
		CsvDb.import_meeting("meeting", params[:dump][:file])
		redirect_to :action => :index, :notice => "Upload successful." 
	end
end
