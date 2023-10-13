class Admin::HomesController < ApplicationController
  def top
    @posts = Post.page(params[:page]).per(4)
  end
end
