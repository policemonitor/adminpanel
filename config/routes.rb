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

  get    'map'                     => 'claims#map'
  get    'crews_map'               => 'crews#live_map'

  get    'thanks'                  => 'claims#thankyoupage'
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
  post   'api/update_crew'         => 'crews#api_update'
  get    'api/crews_map'           => 'crews#api_live_map'
  get    'api/claims_map'          => 'claims#temperature_map'

  get    'signup'     => 'administrators#new'
  post   'disable'    => 'administrators#disable'
end
