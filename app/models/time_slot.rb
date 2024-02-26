class TimeSlot < ApplicationRecord
  belongs_to :barbar

  has_many :appointments

  def formatted_start_time
    start_time.strftime("%Y-%m-%d %H:%M")
  end
  # validates :available_seats, presence: true, numericality: { greater_than_or_equal_to: 0 }

end
