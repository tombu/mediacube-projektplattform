Projektplattform::Application.routes.draw do
  get "statusupdates/index"

  devise_for :users

  resources :users
  resources :searchs
  resources :dashboards
  resources :statusupdates
  resources :statustemplates

  resources :projects do
    resources :media
  end
  
  root :to => "projects#index"
  
  # match "profile" => "users#show"

end
