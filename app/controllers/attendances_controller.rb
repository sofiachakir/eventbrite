class AttendancesController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]
	before_action :event_admin_cannot_attend_as_participant, only: [:new, :create]
	before_action :user_cannot_subscribe_if_already_participating, only: [:new, :create]


  def new
  	@event = Event.find(params[:event_id])
  	@attendance = Attendance.new
    @amount = @event.price*100
  	puts params
  end

  def create
  	@event = Event.find(params[:event_id])

    # Amount in cents
    @amount = @event.price*100

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'eur',
    })

    @attendance = Attendance.create(event: @event, user: current_user, stripe_customer_id: customer.id)

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_event_attendance_path(@event)
  end

  private

  def current_user_is_participant?
  	event = Event.find(params[:event_id])
  	!Attendance.where(event: event,user: current_user).empty?
  end

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
