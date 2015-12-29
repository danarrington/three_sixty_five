Rails.application.routes.draw do
  resources :announcements

  resources :seasons

  resources :runs

  mount Upmin::Engine => '/admin'
  get '/dashboard' => 'home#index', :as => :user_root
  get '/get_leaderboard' => 'home#leaderboard', :as => :leaderboard
  get '/get_recent_activity' => 'home#recent_activity', :as => :recent_activity

  get '/about' => 'visitors#about', :as => :about
  get '/admin/stats' => 'admin#stats', as: :stats
  get '/admin/restart' => 'admin#restart', as:  :restart
  post '/admin/restart' => 'admin#execute_restart', as: :execute_restart

  root to: 'visitors#index'

  devise_for :users, :controllers => { registrations: 'registrations' }
end
