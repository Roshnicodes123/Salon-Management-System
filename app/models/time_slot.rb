class TimeSlot < ApplicationRecord
  belongs_to :barbar
  belongs_to :salon

  has_many :appointments, dependent: :destroy
  validate :validate_seat_capacity, on: :create

  def formatted_start_time
    start_time.strftime("%Y-%m-%d %H:%M")
  end
  private

  def validate_seat_capacity
    errors.add(:base, 'Seat capacity for this time slot has been reached.') if appointments.count >= salon.seat_capacity
  end
end
