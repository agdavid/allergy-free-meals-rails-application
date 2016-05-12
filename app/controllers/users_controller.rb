class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @allergens = @user.allergens
    @recipes = @user.recipes
    @favorites = @user.favorites
  end

  def index
    @users = User.all
  end
end
