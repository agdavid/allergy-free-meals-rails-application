class Allergen < ActiveRecord::Base
  validates :name, presence: true

  has_many :recipe_allergens
  has_many :recipes, through: :recipe_allergens

  has_many :user_allergens
  has_many :users, through: :user_allergens

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>", icon: "67x67>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
