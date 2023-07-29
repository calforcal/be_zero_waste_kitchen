class AddApiIdToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :api_id, :string
  end
end
