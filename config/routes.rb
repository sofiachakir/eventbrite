Rails.application.routes.draw do

  devise_for :users
  root to: 'events#index'
  resources :events do
  	resources :attendances, only: [:new, :create, :index]
    resources :event_picture, only: [:create]
  end
  resources :users, only: [:show] do
    resources :avatar, only: [:create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
