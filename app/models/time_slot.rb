class TimeSlot < ApplicationRecord
  belongs_to :salon

  has_many :Appointments

  # validates :available_seats, presence: true, numericality: { greater_than_or_equal_to: 0 }

end
