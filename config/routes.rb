Rails.application.routes.draw do
  devise_for :users

  # Since each user will only ever have one vote for a given article/comment,
  # I used `resource` instead of `resources` to create a "singular resource".
  # http://guides.rubyonrails.org/routing.html#singular-resources

  resources :articles, only: [:index, :new, :create] do
    resource :vote, only: :update, defaults: { votable_type: 'Article' }
    resources :comments, only: [:index, :create]
  end

  root to: 'articles#index'
end
