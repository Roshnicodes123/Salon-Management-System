class RegistrationsController < Devise::RegistrationsController
  def create
    super
    sign_out(resource)
  end

  private

  def sign_up_params
    params.require(:barbar).permit(:username, :email, :password, :password_confirmation, :salon_id)
  end
end