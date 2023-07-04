Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  as :user do
    get "signin" => "users/sessions#new"
    post "signin" => "users/sessions#create"
    delete "signout" => "users/sessions#destroy"
  end
end
