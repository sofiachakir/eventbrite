Rails.application.routes.draw do

  devise_for :users
  root to: 'events#index'
<<<<<<< HEAD
  resources :events, only: [:new, :create, :show] do
  	resources :attendances, only: [:new, :create]
    resources :event_picture, only: [:create]
=======
  resources :events do
  	resources :attendances, only: [:new, :create, :index]
>>>>>>> d6bddb722ed1af8931fa908a18504fc9bcb70063
  end
  resources :users, only: [:show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
