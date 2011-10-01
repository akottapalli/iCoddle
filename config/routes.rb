Icoddle::Application.routes.draw do
  # landing page related
  root :to => 'leads#new', :as => :homepage
  match '/landing' => 'leads#new'

  # login/register/signup related
  match '/signup/:invitation_token' => 'users#new', :as => :signup
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  # artifacts of cruft
  get "home/index"
  match '/home' => 'home#index'
  match '/users' => 'users#index'

  # actual default REST route management
  # try rake routes to checkout all the helpers created for routes

  # stand alone routing
  resources :leads
  resources :user_sessions

  # nested routing
  resources :users
  resources :pets

  # not stand-alone but not sure if nesting helps 
  resources :invitations
  resources :friendships
end
