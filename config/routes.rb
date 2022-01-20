Rails.application.routes.draw do
  resources :destinations
  devise_for :users
end
