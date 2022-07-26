class UsersController < ApplicationController
  before_action :check_for_admin, :only => [:index]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
    if params[:file].present?
      req = Cloudinary::Uploader.upload(params[:file])
      @user.image = req["public_id"]
    end
    @user.update_attributes(user_params)
    @user.save
  end

  def edit 
    if params[:id].to_i == @current_user.id || @current_user.admin? 
      @user = User.find params[:id] 
    else 
      redirect_to user_path
    end
  end

  def update
    user = User.find params[:id]
    if params[:file].present?
      req = Cloudinary::Uploader.upload(params[:file])
      user.image = req["public_id"]
    end
    user.save
    redirect_to user
  end

  def show
    @user = User.find params[:id]
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password, :admin)
  end
end