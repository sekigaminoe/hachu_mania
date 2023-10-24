class Public::PostsController < ApplicationController
   before_action :authenticate_user!

  def new
    @post = Post.new
    @genres = Genre.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post), notice: "投稿しました。"
    else
      @genres = Genre.all
      render :new, alert: "投稿に失敗しました。"
    end
  end

  def index
    @keyword = search_params[:keyword]
    @posts = Post.search(@keyword).page(params[:page]).per(4)
    @genres = Genre.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "編集内容を更新しました。"
    else
      @genres = Genre.all
      render :edit, alert: "編集内容の更新に失敗しました。"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :genre_id, :user_id, :post_image).merge(user_id: current_user.id)
  end

  def search_params
    params.permit(:keyword)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path
    end
  end
end
