class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc).page(params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    if @user.update(user_params)
      # 保存に成功したらプロフィールページにリダイレクト
      redirect_to user_path, notice: 'プロフィールを編集しました'
    else
      # 保存に失敗した場合は編集画面に戻る
      render 'edit'
    end
  end
  
  def followings
    @title = 'followings'
    @user = User.find(params[:id])
    @users = @user.following_users
    @count = @users.count
    render 'show_follow'
  end
  
  def followers
    @title = 'followers'
    @user = User.find(params[:id])
    @users = @user.follower_users
    @count = @users.count
    render 'show_follow'
  end
  
  def favorites
    @user = User.find(params[:id])
    @title = 'Favorites'
    @count = @user.favorite_microposts.count
    @microposts = @user.favorite_microposts
    render 'favorites/favorites'
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
