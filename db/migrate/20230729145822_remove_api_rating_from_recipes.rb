class RemoveApiRatingFromRecipes < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :api_rating, :float
  end
end
