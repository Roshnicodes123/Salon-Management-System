class Service < ApplicationRecord
  belongs_to :salon
  has_many :appointments
  has_one_attached :image


  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes
  end
end
