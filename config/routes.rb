Rails.application.routes.draw do
  root to: 'home#index'
  get "home" => 'home#index'
  get 'users', to: 'users#index', as: 'users'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  as :user do
    get "signin" => "users/sessions#new"
    post "signin" => "users/sessions#create"
    delete "signout" => "users/sessions#destroy"
  end
  resources :comments

  resources :groups do
    member do
      get 'add_users'
      post 'add_members'
      post 'add_comments'
    end
    resources :posts do
      member do
        post 'add_comments'
      end
    end
  end
end
