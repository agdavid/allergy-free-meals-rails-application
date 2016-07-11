class CommentsController < ApplicationController

  def create
    # "comment"=>{"description"=>"This is a test comment", "user_id"=>"1", "recipe_id"=>"2"}
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "Comment successfully created."
      redirect_to recipe_comment_path(@comment.recipe, @comment)
    else
      render "recipes/show"
    end
  end

  def show
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @comment }
    end
  end

  def index
    @recipe = Recipe.find(params[:recipe_id])
    @comments = @recipe.comments
    respond_to do |format|
      format.html { render :index } #standard recipes/2/comments
      format.json { render json: @comments } #json to inject into DOM
      format.js   { render layout: false } #remote true paradigm
    end 
  end

  private
    def comment_params
      params.require(:comment).permit(:description, :user_id, :recipe_id)
    end

end
