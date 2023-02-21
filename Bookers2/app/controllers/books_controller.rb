class BooksController < ApplicationController
  #before_action :correct_user, only: [:edit, :update]
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end

  def update
    is_matching_login_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path
    else
      render :edit
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  #ストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  #def correct_user
    #@book = Book.find(params[:id])
    #@user = @book.user
    #redirect_to(@book.user) unless @user == current_user
  #end
  
  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end

end
