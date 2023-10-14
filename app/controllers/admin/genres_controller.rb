class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to edit_admin_genre_path(@genre), notice: "登録しました"
    else
      render :index, alert: "登録に失敗しました"
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "編集内容を登録しました"
    else
      render :edit, alert: "編集内容の登録に失敗しました"
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
