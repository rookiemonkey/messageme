Rails.application.routes.draw do

  # SIGN IN
  get '/signin', to: 'sessions#new', as: 'session_new'
  post '/signin', to: 'sessions#create', as: 'session_create'
  delete '/signout', to: 'sessions#destroy', as: 'session_destroy'

  # SIGN UP
  get '/signup', to: 'registrations#new', as: 'registration_new'
  post '/signup', to: 'registrations#create', as: 'registration_create'

end
