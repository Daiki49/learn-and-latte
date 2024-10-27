Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
    #,passwords: 'users/passwords'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "static_pages#top"
  resources :posts, only: %i[index]
  resources :shops, only: %i[index show] do
    resources :posts, only: %i[new create show edit update destroy]
    collection do
      get 'map', to: 'shops#map', as: 'map'
      get 'map.json', to: 'shops#map', defaults: { format: 'json' }
    end
  end

  resource :users, only: [:show] do
    collection do
      get 'profile', to: 'users#profile'
      # get 'my_posts', to: 'users#my_posts'
      # get 'bookmarks', to: 'users#bookmarks'
    end
  end
end
