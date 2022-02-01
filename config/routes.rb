Rails.application.routes.draw do
  root 'home#index'
  resources :favorites
  resources :destinations do
    resources :reviews
  end
  devise_for :users
end
