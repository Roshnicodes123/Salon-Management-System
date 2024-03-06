class AppointmentsController < ApplicationController
  before_action :set_salon, only: %i[new create index show get_appointment_slots]
  # before_action :set_available_time_slots, only: [:new, :create]
  
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
  
    @appointment.date = Date.parse(params[:appointment][:date])
  
    if @appointment.save
      redirect_to salon_appointment_path(@salon, @appointment), alert: 'Appointment booked successfully.'
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
    return render json: { data: "No date selected" } unless date.present?

    @salon = Salon.find(params[:salon_id])  
    @time_slots = @salon.time_slots
    if barbar_id.present?
      @time_slots = @time_slots.where(barbar_id: barbar_id)
    end

    if date.present?
      @time_slots = @time_slots.where("DATE(start_time) = ? ", date)
    end
    
    data = @time_slots.pluck(:id, :start_time)
    render json: { data: data }
  rescue => error
    render json: { data: error }
  end

  private

 
  def set_salon
    @salon = Salon.find_by(id: params[:salon_id])
    redirect_to root_path unless @salon.present?
  end

  def appointment_params
    params.require(:appointment).permit(:barbar_id, :service_id, :time_slot_id, :user_id, :salon_id,:date)
  end
  
  
end
