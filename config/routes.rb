Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :amplifiers
  end

  resources :amplifiers, only: [:index]


  # devise_for :users

  root 'amplifiers#index'
end
