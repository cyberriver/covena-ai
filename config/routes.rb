Rails.application.routes.draw do
  root to: "sessions#index"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :uploads, only: [:create]
  resources :calculations, only: [:create]
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  post '/analyze', to: 'calculations#analyze'
  get '/analyze', to: 'calculations#form'
  get '/history', to: 'sessions#history'

  resources :chat, only: [:index, :create]
  resources :sessions do
    resources :chat_messages, only: [:create]
  end

end
  

