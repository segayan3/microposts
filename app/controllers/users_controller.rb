class UsersController < ApplicationController
  before_action :set_user, only: [:update]
  before_action :login_check, only: [:edit]
  
  def show
    @user = User.find(params[:id])
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
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :profile, :region, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def login_check
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to root_path, notice: "他の方のプロフィールは編集できません"
    end
  end
end
