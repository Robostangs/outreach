ActiveAdmin.register Signup do
  filter :event
  filter :user
  filter :confirmed

  index do 
    selectable_column
    column "Event Date", :sortable => :event do |signup|
      signup.event.event_date
    end
    column :event, :sortable => :event
    column "Member", :sortable => :user do |signup|
      signup.user.full_name
    end
    column :credits_earned
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
        signup.event
      end
      row :event_date do
        signup.event.event_date
      end
      row :description do
        signup.event.description
      end
      row :user do
        signup.user.full_name
      end
      row :credits_earned
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
