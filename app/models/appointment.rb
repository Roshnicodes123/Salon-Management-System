class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :barbar
  belongs_to :salon
  belongs_to :service
end
