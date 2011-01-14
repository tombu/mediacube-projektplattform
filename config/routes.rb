Projektplattform::Application.routes.draw do
  devise_for :users

  resources :users
  resources :searchs
  resources :dashboards

  resources :projects do
    resources :media
  end

  root :to => "projects#index"
  
  # match "profile" => "users#show"

end
