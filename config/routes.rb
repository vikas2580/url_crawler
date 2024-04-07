Rails.application.routes.draw do
  resources :crawler, only: [:index, :create]
end