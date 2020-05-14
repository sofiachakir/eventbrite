Rails.application.routes.draw do

  devise_for :users
  root to: 'events#index'
  resources :events, only: [:new, :create, :show] do
  	resources :attendances, only: [:new, :create]
    resources :event_picture, only: [:create]
  end
  resources :users, only: [:show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
