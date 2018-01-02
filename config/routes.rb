Rails.application.routes.draw do
  root 'users#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :zones, param: :fqdn, format: false, constraints: { fqdn: /[^\/]+/ } do
    get :commit
    get :uncommitted, to: "records#uncommitted"
    resources :records do
      get :commit
    end
  end
end
