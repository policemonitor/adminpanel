Rails.application.routes.draw do
  resources :administrators
  resources :claims do
    collection do
      get 'search'
      post 'search'
    end
  end

  resources :crews

  root to: 'sessions#landing'

  get    'login'    => 'sessions#new'
  post   'login'    => 'sessions#create'
  delete 'logout'   => 'sessions#destroy'

  get    'thanks' => 'claims#thankyoupage'
  get    'map' => 'claims#map'
  get    'fulllist' => 'crews#fulllist'

  get    'search' => 'claims#index'
  get    'allincomeclaims' => 'claims#all_income_claims'

  post   'claims/new' => 'claims#new'
  post   'API' => 'claims#create'
  get    'signup' => 'administrators#new'
end
