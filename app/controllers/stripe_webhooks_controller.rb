class StripeWebhooksController < ApplicationController
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
        session = event.data.object
        debugger
        create_apppointment(event)
      else
        puts "Unhandled event type: #{event.type}"
      end
    end
  
    private
  
    def create_apppointment(event)
      debugger
      session = event.data.object
      metadata = session.metadata

    
    appointment_id = metadata['appointment_id']
    service_id = metadata['service_id']
    salon_id = metadata['salon_id']
    barbar_id = metadata['barbar_id']
    date = metadata['date']
      @appointment = Appointment.new(appointment_id: appointment_id,
      service_id: service_id,
      salon_id: salon_id,
      barbar_id: barbar_id,
      date: date,)
      debugger
      if @appointment.save
        head :ok
      else
        head :unprocessable_entity
      end
    end
  end
  