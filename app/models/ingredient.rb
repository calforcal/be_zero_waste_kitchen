class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  validates :name, presence: true
  validates :units, presence: true, numericality: true
  validates :unit_type, presence: true
end
