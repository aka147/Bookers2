class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :edit_check, only: [:edit, :update]

  def index
    @book = Book.new
    @books = Book.all
    # @user = User.find(@all_book.user.id)
  end

  def show
    @book = Book.new
    @all_book = Book.find(params[:id])
    @user = User.find(@all_book.user.id)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = "successfully"
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
      if @book.update(book_params)
          flash[:success] = "successfully"
          redirect_to book_path(@book.id)
      else
          render "edit"
      end
  end

  def edit
    @book = Book.find(params[:id])

  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
      redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def edit_check
    @book= Book.find(params[:id])
    if current_user.id != @book.user_id
    redirect_to books_path
    end
  end
end
