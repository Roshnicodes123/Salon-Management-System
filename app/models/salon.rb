class Salon < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :barbars
  has_many :services
  has_many :appointments
  has_one_attached :cover_image

  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable


  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes
  end

  # def self.ransackable_associations(auth_object = nil)
  #   authorizable_ransackable_associations
  # end
end