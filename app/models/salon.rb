class Salon < ApplicationRecord
  has_many :barbars
  has_many :users
  has_many :time_slots, dependent: :destroy, through: :barbars

  has_many :services
  has_many :appointments
  has_one_attached :cover_image

  # after_create :create_time_slot

  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes
  end

  def self.ransackable_associations(auth_object = nil)
    ["appointments", "barbars", "cover_image_attachment", "cover_image_blob", "services", "time_slots", "users"]
  end
  
  
  
  def available_seats(time_slot)
    seat_capacity - appointments.where(time_slot: time_slot).count
  end
 
end
