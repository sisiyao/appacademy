Rails.application.routes.draw do
  resources :cats do
    resources :cat_rental_requests, only: [:index]
  end

  resources :cat_rental_requests do
    member do
      patch "approve"
      patch "deny"
    end
  end
end
