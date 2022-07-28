Rails.application.routes.draw do
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only:[:new, :create]

  resource :session, only:[:new, :create, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "posts#index"
end
