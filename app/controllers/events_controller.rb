class EventsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]

  def index
  	@all_events = Event.all
  end

  def new
  	@event = Event.new
  end

  def create
  	@event = Event.new(event_params)
  	@event.admin = current_user
  	if @event.save
  		flash[:success] = "Ton évènement a bien été créé !"
  		redirect_to root_path
  	else
  		render :new
  	end
  end

  private

  def event_params
  	params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
  end

end
