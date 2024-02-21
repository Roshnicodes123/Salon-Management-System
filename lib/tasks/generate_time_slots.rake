namespace :salon do
  desc "Generate time slots starting from 12 PM for the current salon"
  task :generate_time_slots, [:salon_id] => :environment do |task, args|
    debugger
    # salon = Salon.find(args[:salon_id])
    salon = Salon.find(args.salon_id)
    if salon.present?
      start_date = Date.current
      end_date = Date.current + 10.days
      
      # start_date = Date.today.strftime("%Y-%m-%d")
      # end_date = (Date.today + 10.days).strftime("%Y-%m-%d")
      
      start_time = start_date.in_time_zone("Asia/Kolkata")
      end_time = end_date.in_time_zone("Asia/Kolkata")
      
      while start_time < end_time
        if start_time.hour >= 12 && start_time.hour < 16       
          time_slot = TimeSlot.create!(start_time: start_time,end_time: start_time + 1.hour,salon: salon)

          Rails.logger.info "Created time slot: #{time_slot.start_time.strftime('%H:%M')} - #{time_slot.end_time.strftime('%H:%M')}"
        end

        start_time += 1.hour
      end
    else
      puts "Salon not found"
    end
  end
end
