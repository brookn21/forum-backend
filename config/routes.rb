Rails.application.routes.draw do
  resources :comments, only: [:create, :destroy, :index, :show]
  resources :likes, only: [:index, :create, :destroy]
  resources :user_communities
  resources :posts
  resources :communities, only: [:show, :index]
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/login', to: 'sessions#create'
  post '/profile',  to: 'users#profile'
end
