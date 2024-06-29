class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :check_creator, only: [:edit, :update, :destroy]

  def index
    @created_events = current_user.created_events
    @attended_events = current_user.attended_events.where.not(id: @created_events.pluck(:id))
    @events = @created_events + @attended_events
  end

  def show
    @event = Event.find(params[:id])
    @attendees = @event.attendees
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = current_user.created_events.build(event_params)
    @event.creator_id = current_user.id
    if @event.save
      # Create a registration linking the current user to the event
      Registration.create(user: current_user, event: @event)
  
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, notice: 'Event was successfully destroyed.'
  end


  # Custom action to add a user to the event
  def add_user
    @event = Event.find_by(id: params[:event_id])
    @user = User.find_by(id: params[:user_id])
  
    puts "Event ID: #{params[:event_id]}"
    puts "User ID: #{params[:user_id]}"
    
    unless @event && @user
      flash[:alert] = 'Event or user not found.'
      redirect_to events_path
      return
    end
  
    if @event.attendees.exclude?(@user)
      @event.attendees << @user
      flash[:notice] = 'User successfully added to the event.'
    else
      flash[:alert] = 'User is already registered for this event.'
    end
  
    redirect_to event_path(@event)
  end
  
  
  

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :description, :date, :location, :capacity)
    end

    def check_creator
      unless @event.creator_id == current_user.id
        redirect_to events_path, alert: 'You do not have permission to perform this action.'
      end
    end
end
