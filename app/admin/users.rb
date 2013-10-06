ActiveAdmin.register User do
	menu :priority => 3
	filter :first_name
	filter :last_name
	filter :email
	filter :school_id

	index do 
		column :first_name
		column :last_name
		column :email
		column :school_id
		column "Attended" do |user|
			user.meetings_attended
		end
		column "Percent" do |user|
			user.meeting_attendance
		end
		column "Missed" do |user|
			user.missed_mandatory_meetings
		end
		column "Credits" do |user|
			user.credits
		end
		default_actions
	end

	show do |user|
		attributes_table do
			row :first_name
			row :last_name
			row :email
			row :school_id
			row :meetings_attended
			row :meeting_attendance
			row :missed_mandatory_meetings
			row :credits
			row :current_sign_in_ip
			row :last_sign_in_ip
		end
	end
  form do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :school_id
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
