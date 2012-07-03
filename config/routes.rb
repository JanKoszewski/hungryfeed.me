require 'resque/server'

Hungryfeed::Application.routes.draw do
  mount Resque::Server.new, :at => "/resque"
  
  match '/auth/:provider/callback' => 'authentications#create'

  devise_for :users do
    get 'logout' => 'devise/sessions#destroy'
  end

  resources :authentications, only: [:index, :create, :destroy]
  resources :tweets, only: [:index, :show]
  resources :tweet_responses, only: [:create, :new]
  resources :deals, only: [:index, :show]
  resources :deal_emails, only: [:create, :new]

  root to: "main#index"
  
end
