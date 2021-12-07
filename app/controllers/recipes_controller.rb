class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    @taist = @recipe.build_taist
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:notice] = '新しいレシピを投稿しました'
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(current_user.id)
    @recipe = Recipe.find(params[:id])
    @taist = Taist.find_by(recipe_id: params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @taist = Taist.find_by(recipe_id: params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:notice] = "レシピを更新しました"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:notice] = 'レシピを削除しました'
      redirect_to user_path(current_user)
    end
  end

  def search
    @beans = ["モカ", "キリマンジャロ", "コロンビア", "コナ", "マンデリン", "グアテマラ", "ブラジル", "ケニア", "コスタリカ"]
    @tools = ["ハリオ", "カリタ", "メリタ",]

    if params[:roast]
      @recipes = Recipe.where(roast: params[:roast])
      if @recipes.present?
        @keyword = @recipes[0].roast_i18n
      else
        # ハッシュのキー（params[:roast]）でハッシュの値を取得
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
      :user_id,
      taist_attributes: [:id, :recipe_id, :sour, :bitter, :sweet, :flavor, :rich]
    )

  end
end
