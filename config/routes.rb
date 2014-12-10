Rails.application.routes.draw do
  resources :seasons

  resources :runs

  mount Upmin::Engine => '/admin'
  get '/dashboard' => 'home#index', :as => :user_root
  get '/get_leaderboard' => 'home#leaderboard', :as => :leaderboard
  get '/get_user_recent_activity' => 'home#user_recent_activity', :as => :user_recent_activity

  root to: 'visitors#index'

  devise_for :users, :controllers => { registrations: 'registrations' }
end
