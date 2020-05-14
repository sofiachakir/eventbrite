class EventsController < ApplicationController
	before_action :authenticate_user!
  before_action :current_user_is_admin, only: [:edit, :update, :destroy]

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

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    redirect_to event_path(@event)
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path
  end

  private

  def event_params
  	params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location, :event_picture)
  end

  def current_user_is_admin
    # Redirige vers l'accueil si on est pas l'admin
    unless current_user == Event.find(params[:id]).admin
      # Ne peut pas accéder au formulaire d'inscription de son propre évènement
      redirect_to root_path
    end
  end

end
