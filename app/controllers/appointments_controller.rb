class AppointmentsController < ApplicationController
  before_action :set_salon, only: %i[new create index show get_appointment_slots]
  # before_action :set_available_time_slots, only: [:new, :create]
  before_action :fetch_appointment_slot, only: :create

  def index
    # debugger
    if current_user
      @appointments = current_user.appointments.paginate(page: params[:page], per_page: 2)
    else
      @appointments = current_barbar.appointments.paginate(page: params[:page], per_page: 2)
    end
  end
  
  def new
    @appointment = Appointment.new
  end

  def create
    
    @appointment = Appointment.new(appointment_params)
    debugger
  
    @appointment.date = Date.parse(params[:appointment][:date])
    @appointment.time_slot = @time_slot
    if @appointment.save
      redirect_to new_salon_appointment_payment_path(@salon, @appointment)
    else
      puts @appointment.errors.full_messages # Add this line to print errors to the console
      render :new
    end
  end
  

  def show
    @appointment = Appointment.find(params[:id])
    @salon = @appointment.salon 
  end

  def get_appointment_slots
    
    date = params[:date]
    barbar_id = params[:barbar_id]
    return render json: { error: "No date selected" } unless date.present?

    @salon = Salon.find(params[:salon_id])  
    @time_slots = @salon.time_slots
    if barbar_id.present?
      @time_slots = @time_slots.where(barbar_id: barbar_id)
    end

    if date.present?
      @time_slots = @time_slots.where("DATE(start_time) = ? ", date)
    end
    
    data = @time_slots.pluck(:start_time).uniq
    render json: { data: data }
  rescue => error
    render json: { error: error }
  end

  private

  def fetch_appointment_slot
    if params[:appointment][:barbar_id].present?
      @barbar = Barbar.find_by(id: params[:appointment][:barbar_id])
      @time_slot = @barbar.time_slots.where(start_time: params[:appointment][:time_slot]).first
    else
      @time_slot = TimeSlot.where(start_time: params[:appointment][:time_slot]).first
    end

    render json: { error: 'Time Slot not available' } unless @time_slot.present?
  end

 
  def set_salon
    @salon = Salon.find_by(id: params[:salon_id])
    redirect_to root_path unless @salon.present?
  end

  def appointment_params
    params.require(:appointment).permit(:barbar_id, :service_id, :user_id, :salon_id,:date)
  end
  
  
end
