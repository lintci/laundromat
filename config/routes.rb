Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :auth do
        resource :pusher, only: [:create]
      end

      resource :token, only: [:create, :destroy]
      resources :users, only: [:show]

      resources :repositories, only: [:index, :show, :update]
      resources :builds, only: [:index, :show]
    end
  end
end
