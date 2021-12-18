class HomesController < ApplicationController
  def top
    @recipes = Recipe.includes(:user, :favorites).page(params[:page]).per(12)
    @beans = ["モカ", "キリマンジャロ", "コロンビア", "コナ", "マンデリン", "グアテマラ", "ブラジル", "ケニア"]
    @tools = ["ハリオ", "カリタ", "メリタ"]
  end

  def about
  end
end
