Rails.application.routes.draw do
  devise_for :users
  root "events#index"

  resources :users, only: [:show, :edit, :update]

  resources :events do
    # вложенный ресурс комментов
    resources :comments, only: [:create, :destroy]
    resources :subscriptions, only: [:create, :destroy]
    resources :photos, only: [:create, :destroy]
  end
end
