class BooksController < ApplicationController

   before_action :authenticate_user!
    before_action :correct_book,only: [:edit]

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user
    @users = @book.user
    @books = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:create]  ="You have created book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:update]  = "You have updated book successfully."
        redirect_to book_path(@book)
    else
      render :edit
    end

  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
      flash[:destroy]  = "Book was successfully destroyed."
    redirect_to books_path
  end

private

    def book_params
      params.require(:book).permit(:title, :body, :user_id)
    end

    def correct_book
        @book = Book.find(params[:id])
      unless @book.user.id == current_user.id
        redirect_to books_path
      end
    end

end