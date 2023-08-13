Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  
  resources :items do
    collection do
      get 'search', to: 'items#search'
    end
  end
end