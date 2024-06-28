class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :check_creator, only: [:edit, :update, :destroy]

  def index
    @events = current_user.events
  end

  def show
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
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :description, :date, :location, :capacity)
    end

    def check_creator
      unless @event.users.include?(current_user) && @event.creator_id == current_user.id
        redirect_to events_path, alert: 'You do not have permission to perform this action.'
      end
    end
end
