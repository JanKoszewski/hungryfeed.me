Hungryfeed::Application.routes.draw do
  # match '/users/auth/:provider/callback' => 'authentications#create'

  resources :tweets
  root :to => "tweets#index"

  namespace :api do
    namespace :v1 do
      resources :user_infos, :only => [:show]
      resources :users, :only => [:index, :show]
      resources :sessions, :only => [:destroy]
    end
  end
end
