Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  devise_for :salons, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # devise_for :barbars
  devise_for :users
  devise_for :barbars,
    controllers: {
      registrations: 'registrations',
      sessions: 'sessions'
    }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check\
  
  resources :home
  root to: "home#index"


  # Defines the root path route ("/")
  # root "posts#index"
end
