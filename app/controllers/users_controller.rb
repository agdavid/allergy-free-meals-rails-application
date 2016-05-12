class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes
    @favorites = @user.favorites
  end

  def index
    @users = User.all
  end
end
