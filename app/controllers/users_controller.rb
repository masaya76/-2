class UsersController < ApplicationController
  def index
    @users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    if User.find(params[:id]).id == current_user.id
       @user = User.find(params[:id])
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:update]  ="You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end

  end

  private
    def after_sign_out_path_for
      root_path
    end

    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end

end
