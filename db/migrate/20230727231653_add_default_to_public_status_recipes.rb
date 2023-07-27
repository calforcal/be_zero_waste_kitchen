class AddDefaultToPublicStatusRecipes < ActiveRecord::Migration[7.0]
  def change
    change_column :recipes, :public_status, :boolean, :default => true
  end
end
