Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/:id/items', to: 'merchant_items#index'
        get '/:id/invoices', to: 'merchant_invoices#index'
        get '/find', to: 'find#index'
        get '/find_all', to: 'find#show'
        get '/random', to: 'random#index'
        get '/most_revenue', to: 'most_revenue#index'
        get '/revenue', to: 'revenue#index'
      end

      namespace :customers do
        get '/find', to: 'find#index'
        get '/random', to: 'random#index'
        get '/find_all', to: 'find#show'

      end

      namespace :invoice_items do
        get '/find', to: 'find#index'
        get '/random', to: 'random#index'
        get '/find_all', to: 'find#show'
      end

      namespace :invoices do
        get '/find', to: 'find#index'
        get '/random', to: 'random#index'
        get '/find_all', to: 'find#show'
        get '/:id/transactions',to: 'transactions#index'

# GET /api/v1/invoices/:id/invoice_items returns a collection of associated invoice items
# GET /api/v1/invoices/:id/items returns a collection of associated items
# GET /api/v1/invoices/:id/customer returns the associated customer
# GET /api/v1/invoices/:id/merchant returns the associated merchant
      end

      namespace :items do
        get '/find', to: 'find#index'
        get '/random', to: 'random#index'
        get '/find_all', to: 'find#show'
      end

      namespace :transactions do
        get '/find', to: 'find#index'
        get '/random', to: 'random#index'
        get '/find_all', to: 'find#show'
      end

      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
    end
  end
end
