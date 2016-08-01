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

Next Steps: Rails App + jQuery Front-End

1. Render one show page and one index page via jQuery and an Active Model Serialization JSON Backend
  Index page:
  [X] On users#show page, render index of user recipes

  Show page:
  [X] On recipes#show page, after render of comments index, make each a clickable link

2. Use Rails API to create a resource and render the response without a page refresh
  [X] The Show and Index actions above should satisfy

3. Rails API must reveal at least one has-many relationship in the JSON that is then rendered to the page
  [X] The Index action is for a User has-many Recipes and should satisfy

4. Have at least one link that loads, or updates a resource without reloading the page
  [X] The Show action should satisfy

5. Must translate the JSON responses into JavaScript Model Objects.  The Model Objects must have at least one method on the prototype.  Formatters work really well for this
  [X] For Index of user recipes, #display_each_recipe
  [X] For Show of recipe comments, #display_comment

