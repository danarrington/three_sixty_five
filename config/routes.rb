Rails.application.routes.draw do
  resources :seasons

  resources :runs

  mount Upmin::Engine => '/admin'
  get '/dashboard' => 'home#index', :as => :user_root
  root to: 'visitors#index'
  devise_for :users
end
