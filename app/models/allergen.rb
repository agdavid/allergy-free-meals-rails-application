class Allergen < ActiveRecord::Base
  has_many :recipe_allergens
  has_many :recipes, through: :recipe_allergens
end
