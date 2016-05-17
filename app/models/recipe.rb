class Recipe < ActiveRecord::Base
  validates :title, :description, :instruction, presence: true

  # Relationships
  has_many :ingredients
  has_many :items, through: :ingredients

  has_many :recipe_allergens
  has_many :allergens, through: :recipe_allergens

  belongs_to :user
  has_many :favorite_recipes
  has_many :favorited_by, through: :favorite_recipes, source: :user 

  # Paperclip gem
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  # Acts as votable gem
  acts_as_votable

  accepts_nested_attributes_for :ingredients, allow_destroy: true
  accepts_nested_attributes_for :items

  # Custom writer to create ingredients and items
  def ingredients_attributes=(params)
    params.each do |i, ingredient|
      # Avoid duplicating existing ingredient, if being updated
      if ingredient[:id]
        @ingredient = Ingredient.find(ingredient[:id])
      else
        @ingredient = self.ingredients.build
      end 

      # Set ingredient amount and recipe_id
      @ingredient.amount = ingredient[:amount]
      @ingredient.recipe_id = self.id
      
      # Avoid duplicating existing item with find_or_initialize
      @item =  Item.find_or_initialize_by(name: ingredient[:item_attributes][:name].downcase.capitalize)
      @item.save

      @ingredient.item_id = @item.id 
      @ingredient.save
    end
  end

  # Model class methods
  def self.favorite_user_recipe
    # Return the recipe added most to user favorites
    self.joins(:favorite_recipes).group("recipe_id").order("COUNT(*) DESC").limit(1)
  end

  def self.most_upvoted_recipe
    # Return the recipe with most upvotes
    self.order("cached_votes_up DESC").limit(1)
  end

  # Search for matching allergens
  def self.match_allergens(search_allergen_ids)
    search_allergen_ids = search_allergen_ids.collect { |id| id.to_i }
    matched_recipes = []
    self.all.each do |recipe|
      intersect_ids = (recipe.allergen_ids & search_allergen_ids)  
      matched_recipes << recipe if search_allergen_ids.sort == intersect_ids.sort
    end
    matched_recipes
  end      

end
