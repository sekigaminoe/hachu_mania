class Public::GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def index
    @groups = Group.all
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
    if @group.uodate(group_params)
      flash[:notice] = "グループ情報内容を編集しました"
      redirect_to group_path(@group)
    else
      flash[:alert] = "グループ情報内容を編集に失敗しました"
      render :edit
    end
  end

  def destoy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to request.referer
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :owner_id)
  end
end
