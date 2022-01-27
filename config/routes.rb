Rails.application.routes.draw do
  root 'home#index'
  resources :favorites
  resources :destinations
  devise_for :users
end
