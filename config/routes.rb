Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :token, only: [:create, :destroy]
      resources :users, only: [:show]
      resources :repositories, only: [:index, :show, :update]
    end
  end
end
