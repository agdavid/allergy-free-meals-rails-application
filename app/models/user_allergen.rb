class UserAllergen < ActiveRecord::Base
  belongs_to :user 
  belongs_to :allergen 
end
