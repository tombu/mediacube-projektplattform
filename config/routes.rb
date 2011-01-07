Projektplattform::Application.routes.draw do
  resources :projects
  resources :users
  resources :searchs
  resources :dashboards

  resources :projects do
    resources :media
  end

  root :to => "projects#index"

end
