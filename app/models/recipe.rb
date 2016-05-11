class Recipe < ActiveRecord::Base
  has_many :ingredients
  has_many :items, through: :ingredients

  accepts_nested_attributes_for :ingredients, allow_destroy: true
  accepts_nested_attributes_for :items

end
