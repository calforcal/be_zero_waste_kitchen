# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars", { name: "Lord of the Rings"])
#   Character.create(name: "Luke", movie: movies.first)


SavedIngredient.destroy_all
RecipeIngredient.destroy_all
UserRecipe.destroy_all
Ingredient.destroy_all
Recipe.destroy_all
User.destroy_all


@recipe1 = Recipe.create!(name: 'Spaghetti with Marinara')
@recipe2 = Recipe.create!(name: 'Vegan Nachos')
@recipe3 = Recipe.create!(name: 'Pasta Primavera')
@recipe4 = Recipe.create!(name: 'Minestrone')

@recipe1.ingredients.create!(name: 'spaghetti', units: 1, unit_type: 'box')
@recipe1.ingredients.create!(name: 'sauce', units: 1, unit_type: 'can')

@recipe2.ingredients.create!(name: 'chips', units: 1, unit_type: 'bag')
@recipe2.ingredients.create!(name: 'vegan cheese sauce', units: 1, unit_type: 'cup')
@recipe2.ingredients.create!(name: 'salsa', units: 1, unit_type: 'jar')

@recipe3.ingredients.create!(name: 'pasta', units: 1, unit_type: 'box')
@recipe3.ingredients.create!(name: 'sauce', units: 1, unit_type: 'jar')
@recipe3.ingredients.create!(name: 'garlic', units: 1, unit_type: 'clove')

@recipe4.ingredients.create!(name: 'garlic', units: 1, unit_type: 'clove')
@recipe4.ingredients.create!(name: 'pasta', units: 1, unit_type: 'cup')
@recipe4.ingredients.create!(name: 'celery', units: 1, unit_type: 'cup')
@recipe4.ingredients.create!(name: 'beans', units: 1, unit_type: 'can')



user_1 = User.create!(uid: "123")

recipe_1 = Recipe.create!(name: 'Chicken Parm', api_id: "123456789123456789", instructions: ['1. Cook the chicken', '2. Cover in sauce and cheese', '3. Enjoy!'], image_url: 'pic of my chicken parm', cook_time: 45, public_status: true, source_name: user_1.name, source_url: "/api/v1/users/#{user_1.id}")
chicken = Ingredient.create!(name: 'Chicken', units: 2.0, unit_type: 'lbs')
cheese = Ingredient.create!(name: 'Cheese', units: 0.5, unit_type: 'lbs')
recipe_ingredients_1 = recipe_1.recipe_ingredients.create!(ingredient_id: chicken.id)
recipe_ingredients_2 = recipe_1.recipe_ingredients.create!(ingredient_id: cheese.id)

recipe_2 = Recipe.create!(name: 'Meatballs', api_id: "1234567891234567891", instructions: ['1. Cook the meatballs', '2. Cover in sauce', '3. Eat!'], image_url: 'meatballs path', cook_time: 22, public_status: true, source_name: 'Italian Chef', source_url: 'Italian Chef Web')
ground_beef = Ingredient.create!(name: 'ground beef', units: 2.0, unit_type: 'lbs')
eggs = Ingredient.create!(name: 'eggs', units: 2.0, unit_type: 'oz')
recipe_ingredients_3 = recipe_1.recipe_ingredients.create!(ingredient_id: ground_beef.id)
recipe_ingredients_4 = recipe_1.recipe_ingredients.create!(ingredient_id: eggs.id)

recipe_3 = Recipe.create!(name: 'Pasta', api_id: "1234567891234567892", instructions: ['1. Cook Pasta', '2. Cover in butter and cheese', '3. Yum!'], image_url: 'yummy pasta url', cook_time: 10, public_status: true, source_name: 'Italian Chef', source_url: 'Italian Chef Web')
pasta = Ingredient.create!(name: 'pasta', units: 1.0, unit_type: 'lbs')
butter = Ingredient.create!(name: 'butter', units: 2, unit_type: 'oz')
recipe_ingredients_5 = recipe_1.recipe_ingredients.create!(ingredient_id: pasta.id)
recipe_ingredients_6 = recipe_1.recipe_ingredients.create!(ingredient_id: butter.id)

user_recipe_1 = user_1.user_recipes.create!(recipe_id: recipe_1.id, num_stars: 4, cook_status: false, saved_status: true, is_owner: true)
user_recipe_2 = user_1.user_recipes.create!(recipe_id: recipe_2.id, num_stars: 5, cook_status: true, saved_status: true, is_owner: false)

saved_ingredient_1 = user_1.saved_ingredients.create!(ingredient_name: chicken.name, unit_type: chicken.unit_type, units: chicken.units)
saved_ingredient_2 = user_1.saved_ingredients.create!(ingredient_name: cheese.name, unit_type: cheese.unit_type, units: cheese.units)
saved_ingredient_3 = user_1.saved_ingredients.create!(ingredient_name: ground_beef.name, unit_type: ground_beef.unit_type, units: ground_beef.units)
saved_ingredient_4 = user_1.saved_ingredients.create!(ingredient_name: eggs.name, unit_type: eggs.unit_type, units: eggs.units)