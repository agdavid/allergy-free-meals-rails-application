class Allergen < ActiveRecord::Base
  has_many :recipe_allergens
  has_many :recipes, through: :recipe_allergens

  has_many :user_allergens
  has_many :users, through: :user_allergens
end
