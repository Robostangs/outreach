ActiveAdmin.register Meeting do
	action_item :only => :index do
		link_to 'Upload Attendance', :action => 'upload_attend'
	end

	collection_action :upload_attend do
		# create app/views/admin/meetings/upload_attend.html.erb
		render "admin/csv/upload_attend"
		redirect_to :action => :index, :notice => "Upload successful." 
	end

	collection_action :import_attend, :method => :post do
		CsvDb.import_meeting("meeting", params[:dump][:file])
		redirect_to :action => :index, :notice => "Import successful." 
	end
end
