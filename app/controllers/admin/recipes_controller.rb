class Admin::RecipesController < ApplicationController
  # Use with Devise to require login
  before_action :authenticate_user!
  # Use with Pundit to authorize based on policy
  after_action :verify_authorized

  def index
    @recipes = Recipe.all
    authorize :admin, :admin_recipes_index?
  end
  
end