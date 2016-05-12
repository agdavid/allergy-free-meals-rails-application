class RecipesController < ApplicationController

  def index
    if  params[:user_id]
      @user = User.find_by(id: params[:user_id])
      if @user.nil?
        flash[:alert] = "User not found."
        redirect_to users_path
      else
        @recipes = @user.recipes 
      end
    else
      @recipes = Recipe.all
    end
  end

  def show
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      # Filter for a recipe by the user
      @recipe = @user.recipes.find_by(id: params[:id])
      if @recipe.nil?
        flash[:alert] = "Recipe not found."
        redirect_to user_recipes_path(@user)
      end
    else 
      @recipe = Recipe.find(params[:id])
    end
  end

  # Make sure to add authorization
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

  # Make sure to add authorization
  def edit
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      # First, filter for an actual user
      if @user.nil?
        redirect_to users_path, alert: "User not found."
      else
      # Second, filter for an actual recipe of the user
        @recipe = @user.recipes.find_by(id: params[:id])
        if @recipe.nil?
          redirect_to user_recipes_path(@user), alert: "Recipe not found."
        else
          @recipe = Recipe.find(params[:id])    
        end
      end
    else
      @recipe = Recipe.find(params[:id])
    end
  end

  def update
    @recipe = Recipe.find(params[:id])    
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), :notice => "Recipe successfully updated."
    else
      render "edit"
    end
  end

  # Make sure to add authorization
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to root_path, :notice => "Recipe successfully deleted."
  end

  # Acts as votable
  # Make sure to add authorization - only vote if not own recipe
  def upvote
    @recipe = Recipe.find(params[:id])
    @recipe.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @recipe = Recipe.find(params[:id])
    @recipe.downvote_by current_user
    redirect_to :back 
  end

  # Favorite recipes
  def favorite
    @recipe = Recipe.find(params[:id])
    @favorites = current_user.favorites
    if @favorites.include?(@recipe)
      redirect_to :back, alert: "Failed to add. Recipe already in favorites."
    else
      @favorites << @recipe
      redirect_to :back, notice: "Recipe added to favorites."  
    end
  end

  def unfavorite
    @recipe = Recipe.find(params[:id])
    @favorites = current_user.favorites
    if @favorites.include?(@recipe)
      @favorites.delete(@recipe)
      redirect_to :back, notice: "Recipe removed from favorites."
    else
      redirect_to :back, alert: "Failed to remove. Recipe was not in favorites."
    end
  end

  private
    def recipe_params
      params.require(:recipe).permit(:title, :description, :instruction, :user_id, :image,
        :ingredients_attributes => [:id, :amount, :_destroy, :item_attributes => [:id, :_destroy, :name]],
        :allergen_ids => [])
    end
end
