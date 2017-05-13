Rails.application.routes.draw do
  resources :amplifiers
  devise_for :users
  root 'users#index'
end
