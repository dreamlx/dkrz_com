class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_url
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_url
  end

  private
    def user_params
      params.require(:user).permit(
        :openid, :avatar, :name, :email,
        :cell, :number, :channel)
    end
end