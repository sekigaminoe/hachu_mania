class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def index
    @groups = Group.page(params[:page]).per(5)
    @user = User.find(current_user.id)
  end

  def show
    @group = Group.find(params[:id])
    @user = User.find(current_user.id)
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to group_path(@group), notice: "グループを作成しました。"
    else
      render :new, alert: "グループの作成に失敗しました。"
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group), notice: "グループ情報内容を編集しました。"
    else
      render :edit, alert: "グループ情報内容の編集に失敗しました。"
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

  def ensure_user
    group = Group.find(params[:id])
    unless group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

end
