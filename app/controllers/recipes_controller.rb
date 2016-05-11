class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe), :notice => "Recipe successfully created."
    else
      render "new"
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])    
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), :notice => "Recipe successfully updated."
    else
      render "edit"
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to root_path, :notice => "Recipe successfully deleted."
  end

  private
    def recipe_params
      params.require(:recipe).permit(:title, :description, :instruction, :author_id,
        :ingredients_attributes => [:id, :amount, :_destroy, :item_attributes => [:id, :_destroy, :name]],
        :allergen_ids => [])
    end
end
