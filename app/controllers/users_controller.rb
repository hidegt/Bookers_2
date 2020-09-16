class UsersController < ApplicationController
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
    if @user == current_user
      render "edit"
    else
      redirect_to edit_user_path(@user)
    end
  end

  #ユーザー情報アップデートの
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated your information successfully."
      redirect_to user_path(current_user.id)
    else
      @user = User.all
      render ("edit_user_path(@user)")
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
