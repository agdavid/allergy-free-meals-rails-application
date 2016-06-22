class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @allergens = @user.allergens
    @user_recipes = @user.recipes
    @user_favorites = @user.favorites
  end

end
