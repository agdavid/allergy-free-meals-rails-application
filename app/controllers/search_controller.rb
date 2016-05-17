class SearchController < ApplicationController

  def allergen_search
    @allergens = Allergen.all
    if params[:allergen_ids]
      # {"allergen_ids"=>["1", "2"]}
      @recipes = Recipe.match_allergens(params[:allergen_ids])
      flash[:success] = "Recipes successfully found."      
    end
  end

end
