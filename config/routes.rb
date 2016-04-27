Rails.application.routes.draw do
  resources :payments, defaults: {format: :json}
  resources :loans, defaults: {format: :json}
end
