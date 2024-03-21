class StripeWebhooksController < ApplicationController
  skip_before_action :authenticate_user_or_barbar!

    protect_from_forgery

    def payment_success
       
      payload = request.body.read
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      event = nil
  
      begin
          event = Stripe::Webhook.construct_event(
              payload, sig_header, 'whsec_GCEnNduz8CKghqQ5vxHCPdn3cK2WptzD'
          )
      rescue JSON::ParserError => e
          status 400
          return
      rescue Stripe::SignatureVerificationError => e
        
          status 400
          return
      end
  
    
      case event.type
        
      when 'checkout.session.completed'
        # session = event.data.object      

        create_apppointment(event)
      else
        puts "Unhandled event type: #{event.type}"
      end
    end
  
    private
  
    def create_apppointment(event)
      session = event.data.object
      metadata = session.metadata
      
      appointment_id = metadata['appointment_id']
      service_id = metadata['service_id']
      salon_id = metadata['salon_id']
      barbar_id = metadata['barbar_id']
      user_id = metadata['user_id']
      time_slot = metadata['time_slot']
      
      fetch_appointment_slot(time_slot, barbar_id)
      @appointment = Appointment.new(service_id: service_id, salon_id: salon_id, barbar_id: barbar_id, user_id: user_id)
      @appointment.time_slot = @time_slot
      if @appointment.save
        head :ok
      else
        head :unprocessable_entity
      end
    end

    def fetch_appointment_slot(time_slot, barbar_id)
      if barbar_id.present?
        @barbar = Barbar.find_by(id: barbar_id)
        @time_slot = @barbar.time_slots.where(start_time:time_slot).first
      else
        @time_slot = TimeSlot.where(start_time:time_slot).first
      end
    end
  end
  