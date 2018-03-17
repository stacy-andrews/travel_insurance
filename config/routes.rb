Rails.application.routes.draw do
  resources :policy_prices, only: [ :new, :create ]

  root to: redirect('/policy_prices/new', status: 302)

end
