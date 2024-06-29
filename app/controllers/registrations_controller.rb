class RegistrationsController < ApplicationController
    before_action :set_event
    before_action :authenticate_user!
  
    # POST /events/:event_id/registrations
    def create
      @user = current_user
  
      if @event.attendees.include?(@user)
        flash[:alert] = 'You are already registered for this event.'
      else
        @event.attendees << @user
        flash[:notice] = 'Successfully registered for the event.'
      end
  
      redirect_to event_path(@event)
    end
  
    # DELETE /events/:event_id/registrations/:id
    def destroy
      @user = User.find(params[:id])
  
      if @event.attendees.include?(@user)
        @event.attendees.delete(@user)
        flash[:notice] = 'Successfully unregistered from the event.'
      else
        flash[:alert] = 'User is not registered for this event.'
      end
  
      redirect_to event_path(@event)
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:event_id])
    end
  end
  