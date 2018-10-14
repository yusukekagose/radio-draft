Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'

  devise_for :users,
             path: '',
             path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
             controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}

  resources :users, only: [:show]

  resources :radios, only: [:index, :show, :new, :create, :edit, :destroy, :update] do
    member do
      resources :drafts, only: [:new, :create]
      resources :segments, only: [:index, :create]
      resources :speakers, only: [:index, :create]
      delete 'speaker/:speaker_id', to: 'speakers#destroy_radio_speakers'
    end
  end

  resources :drafts, only: [:edit, :update]

  resources :dashboards, only: [:index]

end
