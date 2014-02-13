Rails.application.routes.draw do
  devise_for :users

  resources :articles, only: [:index, :new, :create] do
    resources :comments, only: [:index]
  end

  root to: 'articles#index'
end
