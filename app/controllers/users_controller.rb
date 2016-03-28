class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :check_user, only: [:edit, :update]

  def show 
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Edited Profile!"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def followings
    @title = 'フォロー'
    @user = User.find(params[:id])
    @follow_users = @user.following_users
  end
  
  def followers
    @title = 'フォロワー'
    @user = User.find(params[:id])
    @follow_users = @user.follower_users
    render 'followings'
  end

  
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :region, :body)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def check_user
    if @user != current_user
      redirect_to root_url
    end
  end
  
end
