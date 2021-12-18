class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.includes(:favorites).page(params[:page]).per(12)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = 'プロフィールを更新しました'
      redirect_to user_path(@user)
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
