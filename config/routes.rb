Rails.application.routes.draw do
  resources :runs

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
end
