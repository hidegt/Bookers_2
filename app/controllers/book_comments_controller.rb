class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_params)
    @comment.book_id = @book.id
    @comment.save
    #redirect_to request.referer
  end

  def destroy
    @book = Book.find(params[:book_id])
    book_comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])
    book_comment.destroy
    #redirect_to request.referer
  end

  private
  def book_params
    params.require(:book_comment).permit(:comment)
  end
end