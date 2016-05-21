class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.try(:admin?)
  end

  def redirect_user_with_no_paypal_account
    if current_user.paypals.none?
      redirect_to new_user_paypal_path(current_user)
      flash[:danger] = "You must add a Paypal Account before you can do that"
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:username, :first_name, :last_name, :date_of_birth)
  end
end
