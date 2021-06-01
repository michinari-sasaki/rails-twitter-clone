class PostsController < ApplicationController
  before_action :user_auth
  before_action :post_person,{only:[:edit,:update,:destroy]}

  def index
    @new_post = Post.new
    @posts = Post.all.order(created_at: :desc)
  end
  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
  end
  # def new
  #   @post = Post.new
  # end
  def create
    @new_post = Post.new(content: params[:content],user_id: @login_user.id)
    @post = Post.all.order(created_at: :desc)
    if @new_post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/index")
    end
  end
  def edit
    @post = Post.find_by(id: params[:id])
  end
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
    flash[:notice] = "投稿を編集しました"
    redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/posts/index")
  end

  def post_person
    @post = Post.find_by(id: params[:id])
    if @login_user.id != @post.user_id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end
