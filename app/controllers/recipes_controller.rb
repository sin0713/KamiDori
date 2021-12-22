class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :search, :ranking, :new_order]
  before_action :set_beans_tools, only: [:new_order, :search, :index, :favorites]

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
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user = User.find(@recipe.user_id)
    @taist = Taist.find_by(recipe_id: params[:id])
    @recipe_comment = RecipeComment.new
    @recipe_comments = @recipe.recipe_comments.includes(:user)
  end

  def index
    @recipes = Recipe.includes(:user, :favorites).excluded.page(params[:page]).per(12)
    @new_recipes = Recipe.includes(:user, :favorites).excluded.order(created_at: :desc).limit(3)
    @recipe_ranks = Recipe.includes(:user, :favorites).excluded.find(Favorite.group(:recipe_id).order('count(recipe_id) desc').limit(3).pluck(:recipe_id))
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @taist = Taist.find_by(recipe_id: params[:id])

    unless @recipe.user_id == current_user.id
      flash[:alert] = "アクセス権限はありません。"
      redirect_to root_path
    end

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
      flash[:alert] = 'レシピを削除しました'
      redirect_to user_path(current_user)
    end
  end

  def search

    if params[:roast]
      @recipes = Recipe.includes(:user, :favorites).excluded.where(roast: params[:roast])
      # ハッシュのキー（params[:roast]）でハッシュの値を取得
      @keyword = Recipe.roasts_i18n[params[:roast]]
      if @recipes.blank?
        render 'search'
      end
    elsif params[:grind_size]
      @recipes = Recipe.includes(:user, :favorites).excluded.where(grind_size: params[:grind_size])
      # ハッシュのキー（params[:roast]）でハッシュの値を取得
      @keyword = Recipe.grind_sizes_i18n[params[:grind_size]]
      if @recipes.blank?
        render 'search'
      end
    else
      @recipes = Recipe.includes(:user, :favorites).excluded.search(params[:keyword])
      @keyword = params[:keyword]
    end
  end


  def favorites
    @recipes = current_user.favorites
  end

  def ranking
    @recipe_ranks = Recipe.includes(:user, :favorites, :taist).excluded.limit(20).find(Favorite.group(:recipe_id).order('count(recipe_id) desc').pluck(:recipe_id))
  end

  def new_order
    @new_recipes = Recipe.includes(:user, :favorites).excluded.order(created_at: :desc).page(params[:page]).per(12)
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
      :image,
      :user_id,
      :status,
      taist_attributes: [:id, :recipe_id, :sour, :bitter, :sweet, :flavor, :rich]
    )
  end

  def set_beans_tools
    @beans = ["モカ", "キリマンジャロ", "コロンビア", "コナ", "マンデリン", "グアテマラ", "ブラジル", "ケニア"]
    @tools = ["ハリオ", "カリタ", "メリタ"]
  end
end
