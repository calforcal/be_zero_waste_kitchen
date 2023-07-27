class AddUserSubmittedToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :user_submitted, :boolean
  end
end
