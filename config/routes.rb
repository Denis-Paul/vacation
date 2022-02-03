Rails.application.routes.draw do
  resources :destinations
  devise_for :users do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  root 'home#index'
end
