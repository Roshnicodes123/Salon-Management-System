class Salon < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :barbars
  has_many :users
  has_many :time_slots, dependent: :destroy

  has_many :services
  has_many :appointments
  has_one_attached :cover_image

  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable


  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes
  end

  def available_time_slots_with_seats
    time_slots.where('start_time > ?', DateTime.now).includes(:available_seats)
  end
  
  
  def available_seats(time_slot)
    seat_capacity - appointments.where(time_slot: time_slot).count
  end
 
end
