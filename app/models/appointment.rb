class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :barbar
  belongs_to :salon
  belongs_to :service
  belongs_to :time_slot

  validates :time_slot, presence: true
  validate :validate_seats_availability
  
  validate :validate_time_slot_availability

# validates :time_slot, uniqueness: { scope: :user_id }
attr_accessor :selected_date

  private
  def validate_time_slot_availability
    if time_slot.present? && time_slot.appointments.count >= 10
      errors.add(:base, 'This time slot is fully booked. Please choose another time slot.')
    end
  end

  def validate_seats_availability
    return unless time_slot.present?

    available_seats = salon.available_seats(time_slot)

    errors.add(:base, 'No available seats for the selected time slot.') if available_seats.zero?
  end
end
