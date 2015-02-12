Rails.application.routes.draw do
  resources :feature_announcments

  resources :seasons

  resources :runs

  mount Upmin::Engine => '/admin'
  get '/dashboard' => 'home#index', :as => :user_root
  get '/get_leaderboard' => 'home#leaderboard', :as => :leaderboard
  get '/get_recent_activity' => 'home#recent_activity', :as => :recent_activity

  get '/about' => 'visitors#about', :as => :about
  get '/admin/stats' => 'admin#stats', :as => :stats

  root to: 'visitors#index'

  devise_for :users, :controllers => { registrations: 'registrations' }
end
