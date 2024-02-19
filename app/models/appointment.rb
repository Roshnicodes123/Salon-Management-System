class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :barbar
  belongs_to :salon
  belongs_to :service
  belongs_to :TimeSlot

  validates :time_slot, presence: true
  validate :validate_seats_availability

  private

  def validate_seats_availability
    return unless time_slot.present?

    available_seats = salon.available_seats(time_slot)

    errors.add(:base, 'No available seats for the selected time slot.') if available_seats.zero?
  end
end
