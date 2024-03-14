Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  devise_for :salons, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
 
  devise_for :users
  devise_for :barbars,
    controllers: {
      registrations: 'registrations',
      sessions: 'sessions'
    }
  
  root to: "salons#index"
  resources :salons do
    resources :appointments do

      get :get_appointment_slots, on: :collection
    end
    resources :stripe, only: [] do
      post :create_session, on: :collection
    end 
  end
  
  post '/stripe/payment_success', to: 'stripe_webhooks#payment_success'

  
end
