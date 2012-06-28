require 'resque/server'

Hungryfeed::Application.routes.draw do
  mount Resque::Server.new, :at => "/resque"
  
  match '/auth/:provider/callback' => 'authentications#create'

  devise_for :users do
    get 'logout' => 'devise/sessions#destroy'
  end

  resources :authentications
  resources :tweets
  resources :deals
  resources :tweet_responses

  root to: "main#index"
  
end
