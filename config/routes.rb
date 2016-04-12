Rails.application.routes.draw do
  resources :administrators
  resources :claims

  root :to => "sessions#landing"

  get    'login'    => 'sessions#new'
  post   'login'    => 'sessions#create'
  delete 'logout'   => 'sessions#destroy'

  get    'signup'   => 'administrators#new'
end
