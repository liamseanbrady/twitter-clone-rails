class UsersController < ApplicationController
  before_action :require_user, only: [:index, :show]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'You registered successfully'
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find_by(username: params[:username])
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end