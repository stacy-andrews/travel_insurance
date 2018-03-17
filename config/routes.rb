Rails.application.routes.draw do
  resources :policy_prices

  root to: 'policy_prices#new'
end
