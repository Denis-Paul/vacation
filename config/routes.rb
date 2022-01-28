Rails.application.routes.draw do
  resources :destinations do 
    collection do
      get 'filter', to: 'destinations#filter'
    end
  end
  devise_for :users
  root 'home#index'
end
