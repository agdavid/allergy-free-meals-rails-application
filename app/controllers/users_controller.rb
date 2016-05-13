class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @allergens = @user.allergens
    @recipes = @user.recipes
    @favorites = @user.favorites
  end

end
