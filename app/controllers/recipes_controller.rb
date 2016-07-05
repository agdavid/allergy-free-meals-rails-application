class RecipesController < ApplicationController
  before_action :set_recipe, only: [:update, :destroy, :upvote, :downvote, :favorite, :unfavorite]
  # Use with Devise to require login
  before_action :authenticate_user!, except: [:index, :show]
  # Use with Pundit to authorize based on policy
  after_action :verify_authorized, only: [:update, :destroy, :upvote, :downvote]

  def index
    if  params[:user_id]
      @user = User.find_by(id: params[:user_id])
      if @user.nil?
        flash[:warning] = "User not found."
        redirect_to users_path
      else
        @recipes = @user.recipes
        @favorite_user_recipe = Recipe.favorite_user_recipe.take 
        @most_upvoted_recipe = Recipe.most_upvoted_recipe.take
      end
    else
      @recipes = Recipe.all
      @favorite_user_recipe = Recipe.favorite_user_recipe.take
      @most_upvoted_recipe = Recipe.most_upvoted_recipe.take 
    end
  end

  def show
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      # Filter for a recipe by the user
      @recipe = @user.recipes.find_by(id: params[:id])
      @comment = @recipe.comments.build
      if @recipe.nil?
        flash[:warning] = "Recipe not found."
        redirect_to user_recipes_path(@user)
      end
    else 
      @recipe = Recipe.find(params[:id])
      @comment = @recipe.comments.build
    end
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      flash[:success] = "Recipe successfully created."
      redirect_to recipe_path(@recipe)
    else
      render "new"
    end
  end

  def edit
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      # First, filter for an actual user
      if @user.nil?
        flash[:warning] = "User not found."
        redirect_to users_path
      else
      # Second, filter for an actual recipe of the user
        @recipe = @user.recipes.find_by(id: params[:id])
        if @recipe.nil?
          flash[:warning] = "Recipe not found."
          redirect_to user_recipes_path(@user)
        else
          @recipe = Recipe.find(params[:id]) 
          authorize @recipe   
        end
      end
    else
      @recipe = Recipe.find(params[:id])
      authorize @recipe
    end
  end

  def update
    authorize @recipe    
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe successfully updated."
      redirect_to recipe_path(@recipe)
    else
      render "edit"
    end
  end

  def destroy
    authorize @recipe
    @recipe.destroy
    flash[:success] = "Recipe successfully destroyed."
    redirect_to root_path
  end

  # Acts as votable
  def upvote
    authorize @recipe
    @recipe.upvote_by current_user
    redirect_to :back
  end

  def downvote
    authorize @recipe
    @recipe.downvote_by current_user
    redirect_to :back 
  end

  # Favorite recipes
  def favorite
    @favorites = current_user.favorites
    if @favorites.include?(@recipe)
      flash[:warning] = "Failed to add. Recipe already in favorites."
      redirect_to :back
    else
      @favorites << @recipe
      flash[:success] = "Recipe added to favorites."
      redirect_to :back  
    end
  end

  def unfavorite
    @favorites = current_user.favorites
    if @favorites.include?(@recipe)
      @favorites.delete(@recipe)
      flash[:success] = "Recipe removed from favorites."
      redirect_to :back
    else
      flash[:warning] = "Failed to remove. Recipe was not in favorites."
      redirect_to :back
    end
  end

  private
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(:title, :description, :instruction, :user_id, :image,
        :ingredients_attributes => [:id, :amount, :_destroy, :item_attributes => [:id, :_destroy, :name]],
        :allergen_ids => [])
    end
end
