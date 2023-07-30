# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
RecipeIngredient.destroy_all
Ingredient.destroy_all
Recipe.destroy_all

@recipe1 = Recipe.create!(name: "Spaghetti with Marinara")
@recipe2 = Recipe.create!(name: "Vegan Nachos")
@recipe3 = Recipe.create!(name: "Pasta Primavera")

@recipe1.ingredients.create!(name: "spaghetti", units: 1, unit_type: "box")
@recipe1.ingredients.create!(name: "sauce", units: 1, unit_type: "can")

@recipe2.ingredients.create!(name: "chips", units: 1, unit_type: "bag")
@recipe2.ingredients.create!(name: "vegan cheese sauce", units: 1, unit_type: "cup")
@recipe2.ingredients.create!(name: "salsa", units: 1, unit_type: "jar")

@recipe3.ingredients.create!(name: "pasta", units: 1, unit_type: "box")
@recipe3.ingredients.create!(name: "sauce", units: 1, unit_type: "jar")
@recipe3.ingredients.create!(name: "garlic", units: 1, unit_type: "clove")
