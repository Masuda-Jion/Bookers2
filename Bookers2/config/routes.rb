Rails.application.routes.draw do
  devise_for :users
  get 'homes/about' => 'homes#about', as: 'about'
  root to: "homes#top"
  resources :users, only: [:index, :edit, :update, :show]
  resources :books, only: [:new, :edit, :update, :create, :index, :show, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
