Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :auth do
        resource :pusher, only: [:create]
        resource :token, only: [:create, :destroy]
      end

      resources :users, only: [:show]

      jsonapi_resources :owners, only: [:index, :show]
      jsonapi_resources :repositories, only: [:index, :show, :update]
      resources :builds, only: [:index, :show]
    end
  end

  root to: 'health_check#up'
  get '/up' => 'health_check#up'
end
