Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      resources :merchants do
        get '/items', to: 'merchant_items#index'
        resources :invoices, only: [:index]
      end

      resources :items, only: [:index]
    end
  end
end
