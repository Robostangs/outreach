ActiveAdmin.register Signup do
  index do 
    column "Event Date", :event do |signup|
      Event.find(signup.event_id).event_date
    end
    column :event
    column :user
    column :confirmed do |signup|
      if signup.confirmed then "Yes"
      else "No"
      end
    end
    default_actions
  end

  show do |signup|
    attributes_table do
      row :event do
        Event.find(signup.event_id) 
      end
      row :user do
        User.find(signup.user_id).full_name
      end
      row :confirmed do
        if signup.confirmed then "Yes"
        else "No"
        end
      end
    end

  end
  
end
