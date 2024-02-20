# app/controllers/appointments_controller.rb
class AppointmentsController < ApplicationController
  before_action :set_available_time_slots, only: [:new, :create]
  
  def new
    @appointment = Appointment.new
    @barbars = @salon.barbars
    @services = @salon.services
    @available_time_slots = @salon.available_time_slots
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

  def set_available_time_slots
    
    @salon = Salon.find(params[:salon_id])
    @available_time_slots = @salon.time_slots.where('start_time > ?', DateTime.now)
  end

  def appointment_params
    params.require(:appointment).permit(:barbar_id, :service_id, :time_slot_id, :user_id, :salon_id)
  end
end
