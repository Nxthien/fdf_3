class UsersController < ApplicationController
  def new
    @user = User.new
  end

   def show
    @user = User.find_by_id params[:id]
    if @user.nil?
      flash[:danger] = t "flash.user_nil"
      redirect_to root_path
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :address, :phone_number,
      :password
  end
end
