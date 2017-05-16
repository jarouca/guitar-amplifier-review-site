Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :amplifiers, except: [:index, :show]
    resources :reviews, except: [:index, :show]
  end

  resources :amplifiers, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end

  root 'amplifiers#index'
end
