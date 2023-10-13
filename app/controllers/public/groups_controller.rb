class Public::GroupsController < ApplicationController
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
      flash[:notice] = "グループを作成しました"
      redirect_to group_path(@group)
    else
      flash[:alert] = "グループの作成に失敗しました"
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:notice] = "グループ情報内容を編集しました"
      redirect_to group_path(@group)
    else
      flash[:alert] = "グループ情報内容の編集に失敗しました"
      render :edit
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
end
