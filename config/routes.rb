Rails.application.routes.draw do
  resources :payments, defaults: {format: :json}
  resources :loans, defaults: {format: :json} do
    get 'payments', on: :member
  end
end
