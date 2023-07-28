class SavedIngredient < ApplicationRecord
  belongs_to :user
  validates :ingredient_name, presence: true
  validates :unit_type, presence: true
  validates :units, presence: true
  validates :units, numericality: true 
end
