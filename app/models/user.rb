class User < ApplicationRecord
  has_many :saved_ingredients
  has_many :user_recipes
  has_many :recipes, through: :user_recipes
  validates :uid, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :token, presence: true 
end
