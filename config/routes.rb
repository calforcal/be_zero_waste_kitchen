Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show create]
      get '/recipes/search', to: 'search#index'
      resources :recipes
      resources :ingredients, only: %i[index]
      resources 
    end
  end
end
