class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :confirmation]
  def show
    @user = User.find(params[:id])
    if user_signed_in? && @user.id == current_user.id
      @recipes = @user.recipes.includes(:favorites, :taist).page(params[:page]).per(12)
    else
       @recipes = @user.recipes.includes(:favorites, :taist).excluded.page(params[:page]).per(12)
    end
  end

  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      flash[:alert] = "アクセス権限がありません。"
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = 'プロフィールを更新しました'
      redirect_to user_path(@user)
    else
      render :edit
    end

  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page]).per(10)
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(10)
  end

  def confirmation
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      flash[:alert] = "アクセス権限がありません。"
      redirect_to root_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:alert] = '正常に退会できました'
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end
end
