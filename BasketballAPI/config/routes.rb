Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :games
  resources :players
  resources :favorites

  get :token, controller: 'application'
  get :authenticate_with_token, controller: 'application'
  get 'users/:id/games', to: 'users#games', as: :user_games
  get 'application/search', to: 'application#search', as: :search

end
