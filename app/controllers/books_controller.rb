class BooksController < ApplicationController
  
  #アクションの順番・・・
  def new
    
  end
  
  #新規投稿のフラッシュ
  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render ("/books/index")
    end
  end

  def index
  end

  def show
    @books = Books.new(book_params)
  end
  
end
