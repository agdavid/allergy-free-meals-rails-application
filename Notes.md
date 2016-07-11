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
  Show page:
  [x] On recipes#show page, include comment form
  - On submit of comment form, hijack and show on recipes#show

  Index page: **DO THIS NEXT** 
  [x] On recipes#show page, include link to "Show All Comments"
  [x] On click of button, hijack and show on recipes#show

2. Use Rails API to create a resource and render the response without a page refresh
  - The Show and Index actions above should satisfy

3. Rails API must reveal at least one has-many relationship in the JSON that is then rendered to the page
  -The Index action is for a Recipe has-many Comments and should satisfy

4. Have at least one link that loads, or updates a resource without reloading the page
  - The Index action should satisfy

5. Must translate the JSON responses into JavaScript Model Objects.  The Model Objects must have at least one method on the prototype.  Formatters work really well for this
  - Create comment JS constructor function and #display_comment method on the prototype
  - Create post JS constructor function and #display_post_comments method on the prototype

