ActiveAdmin.register Signup do
  #config.clear_action_items!
  filter :event
  filter :user
  filter :confirmed

  index do 
    selectable_column
    column "Event Date", :sortable => :event do |signup|
      Event.find(signup.event_id).event_date
    end
    column "Event", :sortable => :event do |signup|
      Event.find(signup.event_id).title
    end
    column "Member", :sortable => :user do |signup|
      User.find(signup.user_id).full_name
    end
    column "Confirmed", :sortable => :confirmed do |signup|
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
      row :event_date do
        Event.find(signup.event_id).event_date
      end
      row :description do
        Event.find(signup.event_id).description
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

  batch_action :confirm do |selection|
    Signup.find(selection).each do |signup| 
      signup.confirmed = true
      signup.save
    end
    redirect_to :back
  end

  batch_action :unconfirm do |selection|
    Signup.find(selection).each do |signup| 
      signup.confirmed = false
      signup.save
    end
    redirect_to :back
  end
  
end
