Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show create destroy]
      delete  '/user/:user_id/recipes/:recipe_id', to: 'user_recipes#destroy'
      post '/user/:user_id/ingredients', to: 'user_ingredients#create'
      get '/recipes/search', to: 'search#index'
      resources :recipes
      post '/recipes/:recipe_id', to: 'user_recipes#create'
      resources :ingredients, only: %i[index]
    end
  end
end
