class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # Use for adding custom attributes to strong params
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected 
    # Use for adding custom attributes to strong params
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :remember_me, :first_name, :last_name)}
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :remember_me, :first_name, :last_name, { allergen_ids: [] })}
    end
end
