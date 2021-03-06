class UsersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login @user
      flash[:success] = "Welcome to Team Board!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id])
    if current_user?(user)
      user.destroy
      flash[:success] = "User destroyed."
      redirect_to home_url
    else
      render 'show'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
