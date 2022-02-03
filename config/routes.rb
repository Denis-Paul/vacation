Rails.application.routes.draw do
  resources :destinations do 
    collection do
      get 'filter', to: 'destinations#filter'
    end
  end
  devise_for :users do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  root 'home#index'
end
