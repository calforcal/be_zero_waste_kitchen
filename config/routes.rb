Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show create]
      resources :recipes 
      resources :ingredients, only: %i[index]
      get "/recipes/search", to: "search#index"
    end
  end
end
