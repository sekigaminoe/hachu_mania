class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def genre_search
    @genre_id = params[:genre_id]
    @posts = Post.where(genre_id: @genre_id).page(params[:page]).per(4).order(created_at: :desc)
    @genre = Genre.find(params[:genre_id])
  end
end
