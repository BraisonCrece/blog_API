Rails.application.routes.draw do
  get 'health/', to: 'health#health'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
