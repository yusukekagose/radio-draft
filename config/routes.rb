Rails.application.routes.draw do
  get 'drafts/new'
  get 'users/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'

  devise_for :users,
             path: '',
             path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
             controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}

  resources :radios, only: [:index, :show, :new, :create, :edit, :destroy] do
    member do
      resources :drafts, only: [:new, :create]
    end
  end

end
