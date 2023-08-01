require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :uid }
  end

  describe 'instance methods' do
    let!(:user_1) { User.create!(uid: '123') }

    let!(:recipe_1) do
      Recipe.create!(
        name: 'Chicken Parm', api_id: '123456789123456789',
        instructions: ['1. Cook the chicken', '2. Cover in sauce and cheese', '3. Enjoy!'], image_url: 'pic of my chicken parm', cook_time: 45, public_status: true, source_name: 'user', source_url: "/api/v1/users/#{user_1.uid}"
      )
    end
    let!(:chicken) { Ingredient.create!(name: 'Chicken', units: 2.0, unit_type: 'lbs') }
    let!(:cheese) { Ingredient.create!(name: 'Cheese', units: 0.5, unit_type: 'lbs') }
    let!(:recipe_ingredients_1) { recipe_1.recipe_ingredients.create!(ingredient_id: chicken.id) }
    let!(:recipe_ingredients_2) { recipe_1.recipe_ingredients.create!(ingredient_id: cheese.id) }

    let!(:recipe_2) do
      Recipe.create!(name: 'Meatballs', api_id: '1234567891234567891',
                     instructions: ['1. Cook the meatballs', '2. Cover in sauce', '3. Eat!'], image_url: 'meatballs path', cook_time: 22, public_status: true, source_name: 'Italian Chef', source_url: 'Italian Chef Web')
    end
    let!(:ground_beef) { Ingredient.create!(name: 'ground beef', units: 2.0, unit_type: 'lbs') }
    let!(:eggs) { Ingredient.create!(name: 'eggs', units: 2.0, unit_type: 'oz') }
    let!(:recipe_ingredients_3) { recipe_1.recipe_ingredients.create!(ingredient_id: ground_beef.id) }
    let!(:recipe_ingredients_4) { recipe_1.recipe_ingredients.create!(ingredient_id: eggs.id) }

    let!(:recipe_3) do
      Recipe.create!(name: 'Pasta', api_id: '1234567891234567892',
                     instructions: ['1. Cook Pasta', '2. Cover in butter and cheese', '3. Yum!'], image_url: 'yummy pasta url', cook_time: 10, public_status: true, source_name: 'Italian Chef', source_url: 'Italian Chef Web')
    end
    let!(:pasta) { Ingredient.create!(name: 'pasta', units: 1.0, unit_type: 'lbs') }
    let!(:butter) { Ingredient.create!(name: 'butter', units: 2, unit_type: 'oz') }
    let!(:recipe_ingredients_5) { recipe_1.recipe_ingredients.create!(ingredient_id: pasta.id) }
    let!(:recipe_ingredients_6) { recipe_1.recipe_ingredients.create!(ingredient_id: butter.id) }

    let!(:user_recipe_1) do
      user_1.user_recipes.create!(recipe_id: recipe_1.id, num_stars: 4, cook_status: false, saved_status: true,
                                  is_owner: true)
    end
    let!(:user_recipe_2) do
      user_1.user_recipes.create!(recipe_id: recipe_2.id, num_stars: 5, cook_status: true, saved_status: true,
                                  is_owner: false)
    end

    let!(:saved_ingredient_1) do
      user_1.saved_ingredients.create!(ingredient_name: chicken.name, unit_type: chicken.unit_type,
                                       units: chicken.units)
    end
    let!(:saved_ingredient_2) do
      user_1.saved_ingredients.create!(ingredient_name: cheese.name, unit_type: cheese.unit_type, units: cheese.units)
    end
    let!(:saved_ingredient_3) do
      user_1.saved_ingredients.create!(ingredient_name: ground_beef.name, unit_type: ground_beef.unit_type,
                                       units: ground_beef.units)
    end
    let!(:saved_ingredient_4) do
      user_1.saved_ingredients.create!(ingredient_name: eggs.name, unit_type: eggs.unit_type, units: eggs.units)
    end

    describe '#emissions_reduction' do
      it 'can return the total value of emissions reduced from saved ingredients', :vcr do
        expect(user_1.emissions_reduction).to eq(14.136868307551117)
      end
    end

    describe '#num_recipes_cooked' do
      it 'can return the number of recipes a user as cooked' do
        expect(Recipe.all.count).to eq(3)
        expect(user_1.recipes.count).to eq(2)

        expect(user_1.num_recipes_cooked).to eq(1)
      end
    end

    describe '#num_recipes_created' do
      it 'can return the number of recipes a user has created' do
        expect(Recipe.all.count).to eq(3)
        expect(user_1.recipes.count).to eq(2)

        expect(user_1.num_recipes_created).to eq(1)
      end
    end

    describe '#num_recipes_saved' do
      it 'can return the number of recipes a user has saved' do
        expect(Recipe.all.count).to eq(3)
        expect(user_1.recipes.count).to eq(2)

        expect(user_1.num_recipes_saved).to eq(2)
      end
    end

    describe '#user_stats' do
      it 'can return a condensed version of all user stats', :vcr do
        expect(user_1.user_stats).to eq({
                                          recipes_created: 1,
                                          recipes_cooked: 1,
                                          kg_emissions_saved: 14.14
                                        })
      end
    end

    describe '#recipes_cooked' do
      it 'can return the recipes a user as cooked' do
        expect(Recipe.all.count).to eq(3)
        expect(user_1.recipes.count).to eq(2)

        expect(user_1.recipes_cooked.first.id).to eq(recipe_2.id)
        expect(user_1.recipes_cooked.first.name).to eq(recipe_2.name)
      end
    end

    describe '#recipes_created' do
      it 'can return the recipes a user has created' do
        expect(Recipe.all.count).to eq(3)
        expect(user_1.recipes.count).to eq(2)

        expect(user_1.recipes_created.first.id).to eq(recipe_1.id)
        expect(user_1.recipes_created.first.name).to eq(recipe_1.name)
      end
    end

    describe '#recipes_saved' do
      it 'can return the recipes a user has saved' do
        expect(Recipe.all.count).to eq(3)
        expect(user_1.recipes.count).to eq(2)

        expect(user_1.recipes_saved.first.id).to eq(recipe_1.id)
        expect(user_1.recipes_saved.first.name).to eq(recipe_1.name)

        expect(user_1.recipes_saved.second.id).to eq(recipe_2.id)
        expect(user_1.recipes_saved.second.name).to eq(recipe_2.name)
      end
    end
  end
end
