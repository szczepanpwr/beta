Rails.application.routes.draw do
  resources :adoptions
  devise_for :users
  get '/animals', to: 'animals#index'
  get '/contact', to: 'pages#contact'
  resources :animals do
    resources :adoptions
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "pages#home"
end
