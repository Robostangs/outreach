class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    #@events = Event.desc.all
    @events = Event.desc.paginate(:page => params[:page] )
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def signup
    @user = User.find_by_id(current_user.id)
    @event = Event.find_by_id(params['id'])

    if @event.users.include? current_user
      flash[:error] = "You are already signed up for this event."
      redirect_to event_path(@event)
    elsif @event.full? then
      flash[:error] = "this is full."
      redirect_to event_path(@event)
    else
      @signup = Signup.new( :user_id => @user.id, :event_id => @event.id )
      if @signup.save
        flash[:notice] = "User #{@user.email} signed up for event #{ @event.title }"
        redirect_to event_path(@event)
      else
        flash[:error] = "Failed to sign up for #{ @event.title }"
        redirect_to event_path(@event)
      end
    end
  end

  def signdown
    #TODO check that it is not too late to remove user
    @user = User.find_by_id(current_user.id)
    @event = Event.find_by_id(params['id'])
    if not @event.users.include? current_user
      flash[:error] = "You are not signed up for this event."
      redirect_to event_path(@event)
    else
      @signup = Signup.find_by_user_id(current_user.id)
      if @signup.destroy
        flash[:notice] = "User #{@user.email} removed from event #{ @event.title }"
        redirect_to event_path(@event)
      else
        flash[:error] = "Could not remove from event."
        redirect_to event_path(@event)
      end
    end
  end
end
