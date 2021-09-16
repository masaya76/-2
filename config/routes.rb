Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about',  to:"homes#about"
  resources :books, only: [:new, :create, :edit, :index, :show, :destroy, :update]
  resources :users, only: [:index, :show, :edit, :update]
end
