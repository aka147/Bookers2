class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :edit_check, only: [:edit, :update]

  def index
    @book = Book.new
    @users = User.all #モデルからユーザー全員を取り出している
    @user = current_user
  end

  def show
    @book = Book.new
    @books = Book.all
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "successfully"
    redirect_to user_path(@user.id)
    else
    render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  def edit_check
    @user= User.find(params[:id])
    if current_user.id != @user.id
    redirect_to user_path(current_user)
    end
  end

end