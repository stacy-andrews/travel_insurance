Rails.application.routes.draw do
  resources :policy_prices, only: [ :new, :create ]

  root to: 'policy_prices#new'
end
