Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#index'
  resources :users, only: [:new, :create, :index]
  resources :sessions, only: [:new, :create, :destroy]
  resources :words
  resources :definitions
  get '/login', to: 'sessions#new'
  get '/search', to: 'words#search'
  
end

# root 'users#index'
# resources :users do
# resources :words, shallow: true do
# resources :definitions
# end
# end
# get '/login', to: 'sessions#new'
