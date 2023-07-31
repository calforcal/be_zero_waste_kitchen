Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show create]
      get '/recipes/search', to: 'search#index'
      resources :recipes
      post '/api/v1/recipes/:recipe_id', to: 'user_recipes#create'
      resources :ingredients, only: %i[index]
    end
  end
end
