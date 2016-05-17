class Admin::RecipesController < ApplicationController
  after_action :verify_authorized

  def index
    @recipes = Recipe.all
    authorize :admin, :admin_recipes_index?
  end
  
end