class StripeController < ApplicationController
  before_action :set_salon, :fetch_appointment_slot, :validate_appointment, only: :create_session

  def new
    @appointment = Appointment.find(params[:appointment_id])
  end

  def create_session
    service = Service.find(params[:service_id])
    price = service.price
    service_name = service.name

    session = Stripe::Checkout::Session.create({
      success_url: 'http://127.0.0.1:3000/salons/4/appointments', 
      cancel_url: 'https://example.com/cancel',
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'usd',
            product_data: {
              name: service_name,
            },
            unit_amount: price,
          },
          quantity: 1,
        },
      ],
      mode: 'payment',
      metadata: {
        appointment_id: @appointment.id,
        service_id: params[:service_id],
        salon_id: @salon.id,
        barbar_id: params[:barbar_id],
        date: params[:date]
      }
    })

    redirect_to session.url, allow_other_host: true
  rescue Stripe::CardError => e
    flash[:error] = e.message
    render :new
  end

  private

  def validate_appointment
    @salon = Salon.find_by(id: params[:salon_id])
    @appointment = Appointment.new(
      user_id: params[:user_id],
      barbar_id: params[:barbar_id],
      salon: @salon,  
      service_id: params[:service_id],
      date: Date.parse(params[:date]),
      time_slot: @time_slot
    )

    unless @appointment.valid?
      puts "Appointment is not valid: #{@appointment.errors}"
      render 'appointments/new'
    end
  end

  def fetch_appointment_slot
    if params[:barbar_id].present?
      @barbar = Barbar.find_by(id: params[:barbar_id])
      @time_slot = @barbar.time_slots.find_by(start_time: params[:time_slot])
    else
      @time_slot = TimeSlot.find_by(start_time: params[:time_slot])
    end

    unless @time_slot.present?
      puts "Time slot is not available"
      @appointment = Appointment.new
      @appointment.errors.add(:base, 'Slot unavailable')
      render 'appointments/new'
    end
  end

  def set_salon
    @salon = Salon.find(params[:salon_id])
  end
end
