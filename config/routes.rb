Rails.application.routes.draw do
  get 'sessions/new'
  root 'welcome#index'

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/users/:id/movies', to: 'movies#index', as: 'movies'
  get '/users/:user_id/movies/:movie_id/viewing_parties/new', to: 'viewing_parties#new'
  post '/users/:user_id/movies/movie_id/viewing_parties', to: 'viewing_parties#create'
  get '/users/:user_id/movies/:id', to: 'movies#show', as: 'movie'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # get '/dashboard', to: 'users#show'
  resources :users, only: :show
end
