Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :games
  resources :players
  resources :favorites

  get 'users/:id/games', to: 'users#games', as: :user_games
end
