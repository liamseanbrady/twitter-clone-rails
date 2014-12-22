class UsersController < ApplicationController
  before_action :set_user, only: [:show, :follow]
  before_action :require_user, only: [:index, :show, :follow]
  before_action :require_different_user, only: [:follow]

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

  def show; end

  def follow
    @user.followers << current_user

    if @user.save
      flash[:notice] = "You are now following this user"
    else
      flash[:error] = "Follow was unsuccessful. Try again."
    end

    redirect_to :back
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find_by(username: params[:username])
  end

  def require_different_user
    if @user == current_user
      flash[:error] = "You're not allowed to do that"
      redirect_to :back
    end
  end
end


