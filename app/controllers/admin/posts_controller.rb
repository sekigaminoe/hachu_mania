class Admin::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end

  private

  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end
end
