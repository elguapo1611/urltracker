UrlTracker::Application.routes.draw do
  devise_for :users

  resources :pages, :only => [:index, :show, :edit] do
    member do
      get :run
    end
  end
  root :to => "pages#index"
end
