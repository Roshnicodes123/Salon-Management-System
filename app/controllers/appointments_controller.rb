class AppointmentsController < ApplicationController
  before_action :set_salon, only: %i[new create index show]
  before_action :set_available_time_slots, only: [:new, :create]
  
  def index
    if current_user
      @appointments = current_user.appointments.paginate(page: params[:page], per_page: 10)
    else
      @appointments = current_barbar.appointments.paginate(page: params[:page], per_page: 10)
    end
  end
  
  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      redirect_to salon_appointment_path(@salon, @appointment), alert: 'Appointment booked successfully.'
    else
      render :new
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
    @salon = @appointment.salon 
  end

  def get_appointment_slots
    
    selected_date = params[:date]
    barbar_id = params[:barbar_id]
    
    if selected_date.present?
      date = Date.parse(selected_date)
      available_time_slots = @salon.available_time_slots_for_date(date, barbar_id)
      render json: { time_slots: available_time_slots }
    else
      render json: { error: 'Date is missing' }, status: :unprocessable_entity
    end
  end

  private

  def set_available_time_slots
    if params[:appointment].present? && params[:appointment][:selected_date].present?
      @selected_date = Date.parse(params[:appointment][:selected_date])
      @available_time_slots = @salon.available_time_slots_for_date(@selected_date)
    else
      @selected_date = Date.current
      @available_time_slots = @salon.available_time_slots_for_date(@selected_date)
    end
  end

  def set_salon
    @salon = Salon.find_by(id: params[:salon_id])
    redirect_to root_path unless @salon.present?
  end

  def appointment_params
    params.require(:appointment).permit(:barbar_id, :service_id, :time_slot_id, :user_id, :salon_id,:selected_date)
  end
end
