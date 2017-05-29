Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :amplifiers, except: [:index, :show]
    resources :reviews, except: [:index, :show, :destroy]
  end

  resources :amplifiers, only: [:index, :show] do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :votes

  namespace :api do
    namespace :v1 do
      resources :votes
      devise_for :users
    end
  end

  root 'amplifiers#index'
end
