Projektplattform::Application.routes.draw do
  resources :projects
  resources :search

  root :to => "projects#index"

end
