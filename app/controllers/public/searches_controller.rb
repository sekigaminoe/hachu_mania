class Public::SearchesController < ApplicationController
  def search
  end

  def genre_search
    @genre_id = params[:genre_id]
    @posts = Post.where(genre_id: @genre_id)
    @genre = Genre.find(params[:genre_id])
  end

end
