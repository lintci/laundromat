Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      jsonapi_resource :access_token, only: [:create, :destroy]
      jsonapi_resources :users, only: [:show]
      jsonapi_resources :repositories, only: [:index, :show, :update]
    end
  end
end
