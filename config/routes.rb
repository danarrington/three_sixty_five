Rails.application.routes.draw do
  resources :seasons

  resources :runs

  mount Upmin::Engine => '/admin'
  get '/dashboard' => 'home#index', :as => :user_root
  get '/get_leaderboard' => 'home#leaderboard', :as => :leaderboard

  root to: 'visitors#index'

  devise_for :users
end
