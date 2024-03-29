ActiveAdmin.register Event do
	filter :title
	filter :event_date

	index do 
		column :title
		column :event_date
		column "Start time", :sortable => :start_time do |event|
			event.nice_start_time
		end
		column "End time", :sortable => :end_time do |event|
			event.nice_end_time
		end
		column "Back-out deadline", :sortable => :deadline do |event|
			event.deadline
		end
		column :credits
		column "Filled slots" do |event|
			event.signups.count
		end
		column :max_slots
		default_actions
	end

	show do |event|
		attributes_table do
			row :title
			row :description
			row :event_date
			row :start_time do
				event.nice_start_time
			end
			row :end_time do
				event.nice_end_time
			end
			row :credits
			row :slots do
				" #{event.signups.count}  / #{event.max_slots}"
			end
			row :currently_signed_up do
				event.users.map(&:full_name).join("<br />").html_safe
			end
		end
	end
end
