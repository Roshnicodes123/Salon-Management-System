
class AppointmentsController < ApplicationController
  def new
    @appointment = Appointment.new
    @barbars = Barbar.all
    @services = Service.all
  end

  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      redirect_to root_path, notice: 'Appointment booked successfully.'
    else
      render :new
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:barber_id, :service_id)
  end
end