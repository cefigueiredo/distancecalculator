Rails.application.routes.draw do
  resources :rentals
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'rentals#index'
end
