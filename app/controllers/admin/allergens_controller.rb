class Admin::AllergensController < ApplicationController
  before_action :set_allergen, only: [:edit, :update, :destroy]
  # Use with Devise to require login
  before_action :authenticate_user!
  # Use with Pundit to authorize based on policy
  after_action :verify_authorized

  def index
    @allergens = Allergen.all
    authorize :admin, :admin_allergens_index?
  end

  def new
    @allergen = Allergen.new
    authorize :admin, :admin_allergens_new?
  end

  def create
    @allergen = Allergen.new(allergen_params)
    authorize :admin, :admin_allergens_create?
    if @allergen.save
      flash[:success] = "Allergen successfully created."
      redirect_to admin_allergens_path
    else
      render "new"
    end
  end

  def edit
    authorize :admin, :admin_allergens_edit?
  end

  def update
    authorize :admin, :admin_allergens_update?    
    if @allergen.update(allergen_params)
      flash[:success] = "Allergen successfully updated."
      redirect_to admin_allergens_path
    else
      render "edit"
    end
  end

  def destroy
    authorize :admin, :admin_allergens_destroy?
    @allergen.destroy
    flash[:success] = "Allergen successfully destroyed."
    redirect_to admin_allergens_path
  end

  private
    def set_allergen
      @allergen = Allergen.find(params[:id])
    end

    def allergen_params
      params.require(:allergen).permit(:name, :image)
    end

end