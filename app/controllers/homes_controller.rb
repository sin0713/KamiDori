class HomesController < ApplicationController
  def top
    @recipes = Recipe.includes(:user, :favorites).page(params[:page]).per(12)
    @beans = ["モカ", "キリマンジャロ", "コロンビア", "コナ", "マンデリン", "グアテマラ", "ブラジル", "ケニア"]
    @tools = ["ハリオ", "カリタ", "メリタ"]
    @new_recipes = Recipe.includes(:user, :favorites).order(created_at: :desc).limit(3)
    @recipe_renks = Recipe.find(Favorite.group(:note_id).order('count(recipe_id) desc').limit(3).pluck(:recipe_id))
  end

  def about
  end
end
