Rails.application.routes.draw do
  devise_for :users
  get 'homes/about' => 'homes#about', as: 'about'
  root to: "homes#top"
  resources :users, only: [:show, :edit, :update, :index]
  resources :books, only: [:new, :create, :index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
