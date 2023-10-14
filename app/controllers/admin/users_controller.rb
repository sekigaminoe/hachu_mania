class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(4)
  end

  def index
    @users = User.page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "編集内容を更新しました"
    else
      render :edit, alert: "編集内容の更新に失敗しました"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :profile_image, :is_deleted)
  end
end
