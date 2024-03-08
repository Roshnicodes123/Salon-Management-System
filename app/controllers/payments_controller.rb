
class PaymentsController < ApplicationController
    before_action :set_salon_and_appointment, only: [:new, :create]

    def new
      @appointment = Appointment.find(params[:appointment_id])
    end
  
    def create
      @appointment = Appointment.find(params[:appointment_id])
        Stripe.api_key ='sk_test_51OreMASJqfkZjlueuScOYh5yhz4G6pYjo3Co0LnsRSn8jBnB1FWdOqRumCYDlFzXHRU8w7ajQNG4iMvs9vab27PA00mRAWyfgJ'
        debugger
      charge = Stripe::Charge.create({
        amount: 1000, 
        currency: 'usd',
        source: params[:source],
        description: 'Appointment Payment',
      })
  
      if charge.successful?
        @appointment.update(payment_status: 'paid')
        redirect_to @appointment, notice: 'Payment successful.'
      else
        flash[:error] = 'Payment failed.'
        render :new
      end
    rescue Stripe::CardError => e
      flash[:error] = e.message
      render :new
    end
    def set_salon_and_appointment
        @salon = Salon.find(params[:salon_id])
        @appointment = @salon.appointments.find(params[:appointment_id])
      end
  end
  