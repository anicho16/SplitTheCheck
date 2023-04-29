Rails.application.routes.draw do
  resources :votes
  resources :users
  resources :restaurants do
    member do
      patch :increment_will_split
      patch :increment_wont_split
    end
  end

  # Defines the root path route ("/")
  root "restaurants#index"

  # Routes for sessions controller
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  patch 'restaurants/:id/toggle_favorite', to: 'restaurants#toggle_favorite', as: 'toggle_favorite_restaurant'

  resources :restaurants do
    resources :comments, only: [:create]
  end
end
