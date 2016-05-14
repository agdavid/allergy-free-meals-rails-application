class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth_hash = request.env["omniauth.auth"]
    @user = User.find_or_create_from_omniauth(auth_hash)
    if @user.persisted?
      flash[:success] = "Signed in with Facebook!" 
      sign_in_and_redirect @user
    else
      # Persist @user errors for display
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_path
    end
  end
end