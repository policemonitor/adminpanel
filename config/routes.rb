Rails.application.routes.draw do
  resources :administrators
  root :to => "administrators#new"

  get    'login'    => 'sessions#new'
  post   'login'    => 'sessions#create'
  delete 'logout'   => 'sessions#destroy'

  get    'signup'   => 'administrators#new'
end
