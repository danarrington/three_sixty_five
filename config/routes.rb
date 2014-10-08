Rails.application.routes.draw do
  resources :seasons

  resources :runs

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
end
