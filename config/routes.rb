Rails.application.routes.draw do
  resources :lockers
  root 'lockers#index'
  get '/concierge', to: 'lockers#concierge'
end
