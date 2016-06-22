Object Relational Mapping (ORM):

- User
  has_many :recipes
  
  has_many :favorite_recipes
  has_many :favorites, through: :favorite_recipes, source: :recipe
  
  has_many :user_allergens
  has_many :allergens, through: :user_allergens  

- Recipe
  has_many :ingredients
  has_many :items, through: :ingredients

  has_many :recipe_allergens
  has_many :allergens, through: :recipe_allergens

  belongs_to :user
  
  has_many :favorite_recipes
  has_many :favorited_by, through: :favorite_recipes, source: :user

- Ingredient
  # join table with additional attribute ":amount"
  belongs_to :recipe
  belongs_to :item

- Item
  has_many :ingredients
  has_many :recipes, through: :ingredients

- Allergen
  has_many :recipe_allergens
  has_many :recipes, through: :recipe_allergens
  
  has_many :user_allergens
  has_many :users, through: :user_allergens

- FavoriteRecipe
  # join table
  belongs_to :recipe
  belongs_to :user

- RecipeAllergen
  #join table
  belongs_to :recipe
  belongs_to :allergen

- UserAllergen
  #join table
  belongs_to :user
  belongs_to :allergen



