Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users

  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth',  skip: [:omniauth_callbacks]
    end
  end
end
