Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'players/for_user', to: 'players#for_user', as: :players_for_user
  get 'players/for_game', to: 'players#for_game', as: :players_for_game
  post 'contacts', to: 'contacts#contacts', as: :contacts

  resources :users
  resources :games
  resources :players
  resources :favorites

  get :token, controller: 'application'
  get :authenticate_with_token, controller: 'application'
  get 'users/:id/games', to: 'users#games', as: :user_games
  get 'search', to: 'application#search', as: :search
  get 'get_games', to: 'application#get_games', as: :get_games

  post 'devices', to: 'devices#create', as: :create_device
  post :create_user, controller: 'application'
  post 'apple_authenticate', to: 'application#apple_authenticate', as: :apple_authenticate
end
