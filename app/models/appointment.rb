  class Appointment < ApplicationRecord
    belongs_to :user
    belongs_to :barbar
    belongs_to :salon
    belongs_to :service
    belongs_to :time_slot

    validates :time_slot, presence: true, uniqueness: { scope: :barbar_id }
    # validate :validate_seats_availability
    
    # validate :validate_time_slot_availability

  # attr_accessor :date  
    private
    # def validate_time_slot_availability
    #   errors.add(:base, 'This time slot is fully booked. Please choose another time slot.') if time_slot.present? 
    # end
    

    # def validate_seats_availability
    #   return unless time_slot.present?
    #   errors.add(:base, 'No available seats for the selected time slot.') if salon.available_seats(time_slot).zero?
    # end
  end
