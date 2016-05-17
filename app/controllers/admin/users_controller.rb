class Admin::UsersController < ApplicationController
  after_action :verify_authorized

  def index
    @users = User.all
    authorize :admin, :admin_users_index?    
  end

  def toggle
    @user = User.find(params[:id])
    authorize :admin, :admin_users_toggle?
    @user.toggle!(:admin)
    flash[:success] = "Admin status of #{@user.name} successfully changed."
    redirect_to admin_users_path
  end
end