Rails.application.routes.draw do
  root 'home#index'

  namespace :admin do
    root 'home#index'

    get    :login,  to: 'sessions#new'
    post   :login,  to: 'sessions#create'
    delete :logout, to: 'sessions#destroy'

    resources :users, only: %i[index new create edit update destroy]
  end
end
