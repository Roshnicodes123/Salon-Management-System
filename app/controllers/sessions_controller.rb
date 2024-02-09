# app/controllers/barbers/sessions_controller.rb

class SessionsController < Devise::SessionsController
  before_action :check_status, only: :create

  private

  def check_status
    barbar = Barbar.find_by(email: params[:barbar][:email])
    if barbar.present? && barbar.inactive?
      redirect_to new_barbar_session_path, alert: 'Your account is inactive. Please contact the admin for activation.'
    end
  end
end
