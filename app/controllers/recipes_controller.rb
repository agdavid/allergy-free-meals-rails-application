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
      @recipe = @user.recipes.find_by(id: params[:id])
      if @recipe.nil?
        flash[:alert] = "Recipe not found."
        redirect_to user_recipes_path(@user)
      end
    else 
      @recipe = Recipe.find(params[:id])
    end
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

  # acts_as_votable
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

  private
    def recipe_params
      params.require(:recipe).permit(:title, :description, :instruction, :author_id, :image,
        :ingredients_attributes => [:id, :amount, :_destroy, :item_attributes => [:id, :_destroy, :name]],
        :allergen_ids => [])
    end
end
