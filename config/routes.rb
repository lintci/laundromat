Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :auth do
        resource :pusher, only: [:create]
        resource :token, only: [:create, :destroy]
      end

      resource :user, only: [:show]
      resources :owners, only: [:index, :show]
      resources :repositories, only: [:index, :show, :update]
      resources :builds, only: [:index, :show]
      resources :activations, only: [:create, :destroy]
    end
  end

  root to: 'health_check#up'
  get '/up' => 'health_check#up'
end
