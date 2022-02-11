Rails.application.routes.draw do
  devise_for :users do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  root 'home#index'
  resources :favorites
  resources :destinations do
    resources :reviews
    collection do
      get 'filter', to: 'destinations#filter'
    end
  end
end
