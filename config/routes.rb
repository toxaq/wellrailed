Rails.application.routes.draw do
  resources :films, only: [:index], format: :json
end
