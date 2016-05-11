class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update]

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe), notice: "Recipe was successfully created."
    else
      render "new"
    end
  end

  def edit
  end

  def update   
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: "Recipe was successfully updated."
    else
      render "edit"
    end
  end

  private
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
    
    def recipe_params
      params.require(:recipe).permit(:title, :description, :instructions,
        :ingredients_attributes => [:id, :amount, :_destroy, :item_attributes => [:id, :_destroy, :name]])
    end

end
