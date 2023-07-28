class UserRecipe < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  validates :num_stars, numericality: true
end
