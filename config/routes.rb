Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  get 'posts/index'
  get 'posts/show'
  get 'posts/new'
  get 'posts/edit'

  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "posts#index"
end
