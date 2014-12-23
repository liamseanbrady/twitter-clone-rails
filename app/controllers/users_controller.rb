class UsersController < ApplicationController
  before_action :set_user, only: [:show, :follow, :unfollow]
  before_action :require_user, only: [:index, :show, :follow, :unfollow, :timeline]
  before_action :require_different_user, only: [:follow, :unfollow]

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
    if @user
      current_user.followings << @user
      flash[:notice] = "You are now following #{@user.username}"
    else
      flash[:error] = "Follow was unsuccessful. Try again."
    end

    redirect_to :back
  end

  def unfollow
    if @user
      current_user.followings.delete(@user)
      flash[:notice] = "You stopped following #{@user.username}"
    else
      flash[:error] = "Unfollow was unsuccessful. Try again"
    end

    redirect_to :back
  end

  def timeline
    @statuses = []
    current_user.followings.each do |user|
      @statuses << user.statuses
    end
    @statuses.flatten!.sort_by { |s| s.created_at } if !@statuses.empty?
  end

  def mentions
    current_user.mark_unread_mentions!
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


