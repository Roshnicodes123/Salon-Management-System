class Service < ApplicationRecord
  belongs_to :salon
  has_many :appointments

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes
  end
end
