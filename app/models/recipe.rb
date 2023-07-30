class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :user_recipes
  has_many :users, through: :user_recipes
  validates :name, presence: true
  validates :public_status, presence: true

  def self.find_name(name)
    where("name ILIKE ?", "%#{name}%")
  end

  def self.ingredient_search_details(ingredients)
    term_results = []
    ingredients.each do |ingredient|
      term_results << joins(:ingredients).where(:ingredients => {:name => ingredient})
    end
    first_result = term_results[0]
    all_other_results = term_results.map do |result|
      merge(result)
    end
    require 'pry'; binding.pry
    first_result.all_other_results
  end
end

# term1 = joins(:ingredients).where(:ingredients => {:name => ingredients[0]})
# term2 = joins(:ingredients).where(:ingredients => {:name => ingredients[1]})
# term3 = joins(:ingredients).where(:ingredients => {:name => ingredients[2]})
# term1.merge(term2).merge(term3)

# joins(:ingredients).where(:ingredients => {:name => ingredients })
#     joins(:ingredients).where(:ingredients => {:name => "sauce" }).and(Recipe.joins(:ingredients).where(:ingredients => {:name => "pasta" }))