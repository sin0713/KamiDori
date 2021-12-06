class HomesController < ApplicationController
  def top
    @recipes = Recipe.all
    @beans = ["モカ", "キリマンジャロ", "コロンビア", "コナ", "マンデリン", "グアテマラ", "ブラジル", "ケニア"]
    @tools = ["ハリオ", "カリタ", "メリタ",]
  end

  def about
  end
end
