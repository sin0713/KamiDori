class RecipeCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_comments = @recipe.recipe_comments.includes(:user)
    comment = current_user.recipe_comments.new(recipe_comment_params)
    comment.recipe_id = @recipe.id
    comment.save
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_comments = @recipe.recipe_comments.includes(:user)
    RecipeComment.find_by(id: params[:id]).destroy
  end

  private

  def recipe_comment_params
    params.require(:recipe_comment).permit(:comment)
  end
end
