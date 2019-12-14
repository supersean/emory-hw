Rails.application.routes.draw do
  devise_for :authors
  root "home#index"
  resources :books
  resources :authors, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
