Rails.application.routes.draw do
  resources :sessions do
    collection { post :import }
  end

  namespace :charts do
    get "pass_fail"
  end
  root "sessions#index"
end
