Rails.application.routes.draw do
  resources :investigators
  resources :administrators
  resources :crews
  resources :claims do
    collection do
      get 'search'
      post 'search'
    end
  end


  root to: 'static_pages#landing'

  get    'temperature_map' => 'static_pages#temperature_map'

  get    'login'    => 'sessions#new'
  post   'login'    => 'sessions#create'
  delete 'logout'   => 'sessions#destroy'

  get    'thanks'                  => 'claims#thankyoupage'
  get    'map'                     => 'claims#map'
  get    'fulllist'                => 'crews#fulllist'
  get    'blocked'                 => 'claims#blocked'
  get    'new_claims'              => 'claims#new_claims'
  post   'edit_claim_investigator' => 'claims#edit_assigned_investigator'
  get    'crewslist'               => 'claims#crews_list'
  get    'search'                  => 'claims#index'
  get    'assign_investigator'     => 'claims#assign_investigator'
  get    'allincomeclaims'         => 'claims#all_income_claims'
  post   'claims/new'              => 'claims#new'
  post   'api/new_claim'           => 'claims#create'
  get    'api/claims_map'          => 'claims#temperature_map'

  get    'signup'     => 'administrators#new'
  post   'disable'    => 'administrators#disable'
end
