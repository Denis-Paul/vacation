Rails.application.routes.draw do
  root 'home#index'
  resources :favorites
  resources :destinations
  devise_for :users do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
end
