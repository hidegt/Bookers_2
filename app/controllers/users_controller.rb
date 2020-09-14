class UsersController < ApplicationController
  before_action :authenticate_user!
  
  #新規登録、ログイン後のフラッシュshow page
  #@bookのインスタンスを持ってくる
  def show
    @user = User.find(params[:id])
    @books = @user.books.reverse_order
    @book = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
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
