Rails.application.routes.draw do
  namespace :backend do
    get '/' => 'dashboard#show'
    resources :sessions, only: [:new, :create, :destroy]
  end
end
