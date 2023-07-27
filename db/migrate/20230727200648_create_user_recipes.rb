class CreateUserRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :user_recipes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.integer :num_stars
      t.boolean :cook_status
      t.boolean :saved_status
      t.boolean :is_owner

      t.timestamps
    end
  end
end
