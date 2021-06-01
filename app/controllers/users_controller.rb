class UsersController < ApplicationController
  before_action :user_auth,{only:[:index, :edit, :update, :show]}
  before_action :ensure_correct_user,{only:[:edit, :update]}
  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "default_user.jpg",
      password: params[:password],
      activation_digest: params[:email],
      activated: true,
      activated_at: Time.zone.now
    )
    @password = params[:password]
    if @user.save
    session[:user_id] = @user.id
    redirect_to("/users/index")
    else
      render("users/new")
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.post
    @user_posts = Post.where(user_id: params[:id])
  end

  def likes
    @user = User.find_by(id: params[:id])
    @posts = @user.post
    @likes = Like.where(user_id: @user.id)
    @user_posts = Post.where(user_id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
    # if @login_user.id == @user.id
    # else
    # flash[:notice] = "権限がありません"
    # redirect_to("/posts/index")
    # end
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      File.binwrite("public/user_images/#{@user.image_name}",params[:image].read)
    end
    if @user.save
      flash[:notice] = "編集が成功しました"
      redirect_to("/users/index")
    else
      render("users/edit")
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email:params[:email])
    @email = params[:email]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to("/users/index")
      flash[:notice] = "ログインしました"
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def ensure_correct_user
    if params[:id].to_i != @login_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/users/index")
    end
  end

end
