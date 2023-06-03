class BooksController < ApplicationController
  before_action :is_matching_login_user_book, only: [:edit, :update]

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def index
    @books = Book.all
    @book_new = Book.new
    @user = current_user
  end

  def new
    @book_new = Book.new
  end

  def create
    @book_new = Book.new(book_params)
    @books = Book.all
    @book_new.user_id = current_user.id
    @user = @book_new.user
    if @book_new.save
      flash[:notice] = "You have created book successfully."
      redirect_to @book_new
    else
      render "index"
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.delete
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user_book
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end
end
