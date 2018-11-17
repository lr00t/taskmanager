Rails.application.routes.draw do
  root to: 'tasks#index'

  get 'sessions/new'
  resources :users
  resources :sessions

  get '/sign_up', to: 'users#new', as: :sign_up
  get '/sign_in', to: 'sessions#new', as: :sign_in
  get '/logout', to: 'sessions#destroy', as: :logout

  resources :tasks do
    member do
      put 'start'
      put 'finish'
    end
  end
end
