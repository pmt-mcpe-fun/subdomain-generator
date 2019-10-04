Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get '/records', to: 'record#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
