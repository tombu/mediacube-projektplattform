Projektplattform::Application.routes.draw do
  resources :projects
  resources :users

  root :to => "projects#index"

end
