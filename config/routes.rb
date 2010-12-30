Projektplattform::Application.routes.draw do
  resources :projects
  resources :users
  resources :searchs

  root :to => "projects#index"

end
