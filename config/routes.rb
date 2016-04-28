Rails.application.routes.draw do
  resources :payments, defaults: {format: :json}, only: [:show, :index]
  resources :loans, defaults: {format: :json}, only: [:show, :index] do
    get 'payments', on: :member
  end
end
