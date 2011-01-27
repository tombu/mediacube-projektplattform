Projektplattform::Application.routes.draw do
  get "notifications/index"

  get "statusupdates/index"

  devise_for :users
  
  resources :users
  resources :searchs
  resources :dashboards
  resources :statusupdates
  resources :notifications
  resources :jobs
    
  resources :projects do
    member do
      put :follow
      delete :unfollow
      delete :leave
      put :join
      post :apply
    end
    resources :media
  end
  
  root :to => "projects#index"

end
