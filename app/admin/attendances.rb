ActiveAdmin.register Attendance do
  menu :priority => 7
  filter :meeting
  filter :user
  filter :present

  index do 
    column :meeting
    column "Meeting Date", :sortable => :event do |attend|
      attend.meeting.meeting_date.strftime("%a, %b #{attend.meeting.meeting_date.day.ordinalize}, %Y")
    end
    column "User", :sortable => :user_id do |attend|
      attend.user.full_name
    end
    column "Mandatory" do |attend|
      if attend.meeting.mandatory then "Yes"
      else "No"
      end
    end
    column "Present", :sortable => :present do |attend|
      if attend.present then "Yes"
      else "No"
      end
    end
    default_actions
  end

  show do |signup|
    attributes_table do
      row :meeting do
        attendance.meeting
      end
      row :meeting_date do
        attendance.meeting.meeting_date.strftime("%A, %B #{attendance.meeting.meeting_date.day.ordinalize}, %Y")
      end
      row :description do
        attendance.meeting.description
      end
      row :user do
        attendance.user
      end
      row :user_id do
	attendance.user_id
      end
      row :mandatory do
        if attendance.meeting.mandatory then "Yes"
        else "No"
	end
      end
      row :present do
        if attendance.present then "Yes"
        else "No"
        end
      end
    end
  end

  batch_action :present do |selection|
    Attendance.find(selection).each do |attend| 
      attend.present = true
      attend.save
    end
    redirect_to :back
  end

  batch_action :absent do |selection|
    Attendance.find(selection).each do |attend| 
      attend.preset = false
      attend.save
    end
    redirect_to :back
  end
end
