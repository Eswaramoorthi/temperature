Rails.application.routes.draw do
  resources :thermostats, only: [:show] do
    resources :readings, only: [:show, :create]
  end
end
