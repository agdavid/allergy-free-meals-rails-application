class Admin::AllergensController < ApplicationController

  def index
    @allergens = Allergen.all
  end

  def new
    @allergen = Allergen.new
  end

  def create
    @allergen = Allergen.new(allergen_params)
    if @allergen.save
      flash[:success] = "Allergen successfully created."
      redirect_to admin_allergens_path
    else
      render "new"
    end
  end

  def edit
    @allergen = Allergen.find(params[:id])
  end

  def update
    @allergen = Allergen.find(params[:id])    
    if @allergen.update(allergen_params)
      flash[:success] = "Allergen successfully updated."
      redirect_to admin_allergens_path
    else
      render "edit"
    end
  end

  def destroy
    @allergen = Allergen.find(params[:id])
    @allergen.destroy
    flash[:success] = "Allergen successfully destroyed."
    redirect_to admin_allergens_path
  end

  private
    def allergen_params
      params.require(:allergen).permit(:name, :image)
    end

end