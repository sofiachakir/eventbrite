class AttendancesController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]
	before_action :event_admin_cannot_attend_as_participant, only: [:new, :create]
	before_action :user_cannot_subscribe_if_already_participating, only: [:new, :create]


  def new
  	@event = Event.find(params[:event_id])
  	@attendance = Attendance.new
  	puts params
  end

  def create
  	@event = Event.find(params[:event_id])
  	@attendance = Attendance.new(event: @event, user: current_user)
  	
  end

  def current_user_is_participant?
  	event = Event.find(params[:event_id])
  	!Attendance.where(event: event,user: current_user).empty?
  end

  private

  def event_admin_cannot_attend_as_participant
  	# Redirige vers l'accueil si on est l'admin
  	if current_user == Event.find(params[:event_id]).admin
  		# Ne peut pas accéder au formulaire d'inscription de son propre évènement
      redirect_to root_path
    end
  end

  def user_cannot_subscribe_if_already_participating
  	# Renvoie vrai si on est un nouveau participant
  	if current_user_is_participant?
       redirect_to root_path
    end
  end

end
