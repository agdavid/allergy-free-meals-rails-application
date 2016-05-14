class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def toggle
    @user = User.find(params[:id])
    @user.toggle!(:admin)
    flash[:success] = "Admin status of #{@user.name} successfully changed."
    redirect_to admin_users_path
  end
end