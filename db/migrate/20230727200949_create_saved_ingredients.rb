class CreateSavedIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :saved_ingredients do |t|
      t.references :user, null: false, foreign_key: true
      t.string :ingredient_name
      t.string :unit_type
      t.float :units

      t.timestamps
    end
  end
end
