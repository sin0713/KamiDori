class RecipesController < ApplicationController
  def new
  end

  def show
  end

  def edit
  end

  def search
    @beans = ["モカ", "キリマンジャロ", "コロンビア", "コナ", "マンデリン", "グアテマラ", "ブラジル", "ケニア", "コスタリカ"]
    @tools = ["ハリオ", "カリタ", "メリタ",]

    if params[:roast]
      @recipes = Recipe.where(roast: params[:roast])
      if @recipes.present?
        @keyword = @recipes[0].roast_i18n
      else
        @keyword = Recipe.roasts_i18n[params[:roast]]
        render 'search'
      end
    else
      @recipes = Recipe.search(params[:keyword])
      @keyword = params[:keyword]
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :roast,
      :bean,
      :tool,
      :extraction_time_minutes,
      :extraction_time_seconds,
      :pre_infusion_time,
      :temperature,
      :grind_size,
      :amount_of_beans,
      :amount_of_extraction,
      :introduction,
      :image_id,
      :user_id
      )

  end
end
