class Public::PostsController < ApplicationController
   before_action :guest_check, only: [:new]
  def new
    @post = Post.new
    @genres = Genre.all
  end

  def create
    # @user = current_user
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to post_path(@post)
    else
      @genres = Genre.all
      flash[:alert] = "投稿に失敗しました"
      render :new
    end
    # @post.user_id = @user.id

    # if params[:draft].present?
    #   @post.status = :draft
    # else
    #   @post.status = :published
    # end

    # if @post.save
    #   if @post.draft?
    #     redirect_to dashboard_posts_path, notice: '下書きが保存されました。'
    #   else
    #     redirect_to post_path(@post), notice: '投稿が公開されました。'
    #   end
    # else
    #   render :new
    # end
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
    # @user = current_user
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "編集内容を更新しました"
      redirect_to post_path(@post)
    else
      flash[:alert] = "編集内容の更新に失敗しました"
      render :edit
    end

    # @post.assign_attributes(post_params)

    # if params[:draft].present?
    #   @post.status = :draft
    #   notice_message = "下書きを保存しました。"
    #   redirect_path = dashboard_posts_path
    # elsif params[:unpublished].present?
    #   @post.status = :unpublished
    #   notice_message = "非公開にしました。"
    #   redirect_path = dashboard_posts_path
    # else
    #   @post.status = :published
    #   notice_message = "投稿を更新しました。"
    #   redirect_path = post_path(@post)
    # end

    # if @post.save
    #   redirect_to redirect_path, notice: notice_message
    # else
    #   render :edit
    # end
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

  # def ensure_guest_user
  #   @post = Post.find(params[:id])
  #   @user = @post.user
  #   if @user.guest_user?
  #     redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
  #   end
  # end

  def guest_check
    if current_user == User.find(5)
      redirect_to root_path,notice: "このページを見るには会員登録が必要です。"
    end
  end
end
