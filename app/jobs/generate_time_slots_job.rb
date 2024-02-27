class GenerateTimeSlotsJob < ApplicationJob
  queue_as :default

  def perform(barbar_id)
    barbar = Barbar.active.find_by(id: barbar_id)

    if barbar.present?
      start_date = Date.current
      end_date = Date.current + 10.days

      start_time = start_date.in_time_zone("Asia/Kolkata").change(hour: 12, min: 0)
      end_time = end_date.in_time_zone("Asia/Kolkata").change(hour: 16, min: 0)

      while start_time < end_time
        if start_time.hour >= 12 && start_time.hour < 16
          time_slot = TimeSlot.find_or_create_by!(start_time: start_time, end_time: start_time + 1.hour, barbar: barbar)

          Rails.logger.info "Created time slot for #{barbar.username}: #{time_slot.start_time.strftime('%H:%M')} - #{time_slot.end_time.strftime('%H:%M')}"
        end

        start_time += 1.hour
      end

      Rails.logger.info "Slot creation completed"
    else
      Rails.logger.error "Barber not found"
    end
  end
end
