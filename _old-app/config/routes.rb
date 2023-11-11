Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'tunes#index'
  resources :tunes do
    collection { get 'search' }
  end

  unless Rails.env.production?
    namespace :anonymous do
      get 'show', :action => :show
    end
  end

end
