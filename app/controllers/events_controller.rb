class EventsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]

  def index
  	@all_events = Event.all
  end

  def new
  	@event = Event.new
  end

  def create
    puts params
  	@event = Event.new(event_params)
  	@event.admin = current_user
  	if @event.save

  		flash[:success] = "Ton évènement a bien été créé !"
  		redirect_to event_path(@event)
  	else
  		render :new
  	end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
  	params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location, :event_picture)
  end

end
