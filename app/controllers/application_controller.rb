class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!
  before_action :set_current_salon


  # before_action :authenticate_barbar!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
  private

  def set_current_user
    @current_user = current_user
    set_current_salon if @current_user.present?
  end

  def set_current_salon
    @current_salon = current_user.salon if current_user.present? && current_user.salon.present?
  end
  
end