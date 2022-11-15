Rails.application.routes.draw do
  get 'health/', to: 'health#health'
  resources :posts, only: [:index, :show]

  # root "articles#index"
end
