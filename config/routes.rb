Rails.application.routes.draw do
  devise_for :users

  resources :articles, only: [:index, :new, :create] do
    resource :vote, only: :update, defaults: { votable_type: 'Article' }
    resources :comments, only: [:index, :create]
  end

  root to: 'articles#index'
end
