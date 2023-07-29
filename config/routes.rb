Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show create]
      resources :recipes 
      resources :ingredients, only: %i[index]
      get "/recipes/search", to: "search#index"
    end
  end
end
