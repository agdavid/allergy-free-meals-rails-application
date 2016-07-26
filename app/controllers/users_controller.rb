class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @allergens = @user.allergens
    @user_recipes = @user.recipes
    @user_favorites = @user.favorites
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @user }
    end
  end

end
