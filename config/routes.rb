Rails.application.routes.draw do
  root 'top#index'

  namespace :admin do
    root 'top#index'
  end
end
