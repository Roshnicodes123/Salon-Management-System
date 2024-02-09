class RegistrationsController < Devise::RegistrationsController
  def create
    super
    sign_out(resource)
  end
end