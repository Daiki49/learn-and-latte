Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "static_pages#top"

  get "terms_of_use", to: "static_pages#terms_of_use"
  get "privacy_policy", to: "static_pages#privacy_policy"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  resources :posts, only: %i[index show]

  resources :shops, only: %i[index show] do
    resources :posts, only: %i[new create show edit update destroy]
    collection do
      get 'map', to: 'shops#map', as: 'map'
      get 'map.json', to: 'shops#map', defaults: { format: 'json' }
      get :auto_search
    end
    collection do
      get :bookmarks
    end
  end

  resources :bookmarks, only: %i[create destroy]
  resources :likes, only: %i[index create destroy]

  resource :user, only: [:show]

  get 'images/ogp_image.png', to: 'images#ogp', as: 'images_ogp'
end
