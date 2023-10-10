class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @genres = Genre.all
  end

  def create
    @post = Post.new(post_params)
    if params[:post]
      if @post.save(context: :publicize)
        redirect_to post_path(@post), notice: "投稿しました！"
      else
        render :new, alert: "投稿できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # 下書きボタンを押下した場合
    else
      if @post.update(is_draft: true)
        redirect_to user_path(current_user), notice: "投稿を下書き保存しました！"
      else
        render :new, alert: "下書きに保存できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end
  end

  def index
    @posts = Post.all.search(params[:search])
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
    # 下書きレシピの更新（公開）の場合
    if params[:publicize_draft]
      @post.attributes = post_params.merge(is_draft: false)
      if @post.save(context: :publicize)
        redirect_to post_path(@post.id), notice: "投稿しました！"
      else
        @post.is_draft = true
        render :edit, alert: "投稿できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # 公開済みレシピの更新の場合
    elsif params[:update_post]
      @post.attributes = post_params
      if @post.save(context: :publicize)
        redirect_to post_path(@post.id), notice: "投稿内容をを更新しました！"
      else
        render :edit, alert: "投稿内容を更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # 下書きレシピの更新（非公開）の場合
    else
      if @post.update(post_params)
        redirect_to post_path(@post.id), notice: "下書きを更新しました！"
      else
        render :edit, alert: "下書きの内容を更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to request.referer
  end

  private

  def post_params
    params.require(:post).permit(:genre_id, :user_id, :post_image, :title, :body, :is_draft).merge(user_id: current_user.id)
  end

end
