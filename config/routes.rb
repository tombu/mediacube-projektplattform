Projektplattform::Application.routes.draw do
  resources :projects do
    resources :medias
  end
  
  resources :users
  resources :searchs
  resources :dashboards

  root :to => "projects#index"

end
