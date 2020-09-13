class UsersController < ApplicationController
  before_action :authenticate_user!
  
  #新規登録、ログイン後のフラッシュshow page
  #@bookのインスタンスを持ってくる
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  #ユーザー情報アップデートの
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path
    else
      @user = User.all
      render ("users/edit")
    end
  end
  
  
  private
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end