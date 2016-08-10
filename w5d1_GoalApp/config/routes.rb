Rails.application.routes.draw do
  resource :session
  resources :users
  resources :goals
end
