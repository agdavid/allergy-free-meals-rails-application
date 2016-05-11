class Recipe < ActiveRecord::Base
  has_many :ingredients
  has_many :items, through: :ingredients

  has_many :recipe_allergens
  has_many :allergens, through: :recipe_allergens

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
end
