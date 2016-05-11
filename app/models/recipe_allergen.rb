class RecipeAllergen < ActiveRecord::Base
  belongs_to :recipe 
  belongs_to :allergen 
end
