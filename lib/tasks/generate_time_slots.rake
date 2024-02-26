namespace :salon do
  desc "Generate time slots starting from 12 PM for the current salon"
  task :generate_time_slots, [:salon_id] => :environment do |task, args|
    
    salon = Salon.find(args.salon_id)
    if salon.present?
      
      start_date = Date.current
      end_date = Date.current + 10.days

      salon.barbars.each do |barbar|
        
        start_time = start_date.in_time_zone("Asia/Kolkata").change(hour: 12, min: 0)
        
        end_time = end_date.in_time_zone("Asia/Kolkata").change(hour: 16, min: 0)
        debugger
        while start_time < end_time
          if start_time.hour >= 12 && start_time.hour < 16       
            time_slot = TimeSlot.create!(start_time: start_time, end_time: start_time + 1.hour,  barbar: barbar)

            Rails.logger.info "Created time slot for #{barbar.username}: #{time_slot.start_time.strftime('%H:%M')} - #{time_slot.end_time.strftime('%H:%M')}"
          end

          start_time += 1.hour
        end
      end
    else
      puts "Salon not found"
    end
  end
end
