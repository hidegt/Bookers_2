class UsersController < ApplicationController
  #usersとbooksの両方にいれる
  before_action :authenticate_user!

  #新規登録、ログイン後のフラッシュshow page
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    #自分のアカウントでない人が編集しようとしたときに、不可にするための設定
    #否定演算を使うことでコードが短くなる
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  #ユーザー情報アップデートの
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated your information successfully."
      redirect_to user_path(current_user.id)
    else
      render 'edit'
    end
  end

  def follow
    @user  = User.find(params[:id])
    @users = @user.followed
    redirect_to request.referer
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    redirect_to request.referer
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
