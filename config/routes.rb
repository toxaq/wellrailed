Rails.application.routes.draw do
  resources :films, only: [:index], defaults: {format: :json}
  resources :actors, only: [:index], defaults: {format: :json}
end
