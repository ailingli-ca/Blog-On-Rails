Rails.application.routes.draw do
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only:[:new, :create, :edit, :update]

  resource :session, only:[:new, :create, :destroy]

  get '/password', to: 'users#edit_password', as: :edit_password
  post '/password', to: 'users#update_password', as: :update_password

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "posts#index"
end
