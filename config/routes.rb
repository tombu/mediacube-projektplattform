Projektplattform::Application.routes.draw do
  get "search/index"

  resources :projects
  resources :search

  root :to => "projects#index"

end
