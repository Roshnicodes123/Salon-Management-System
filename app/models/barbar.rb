class Barbar < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
      
  enum status: {inactive: 0, active: 1}

  after_create :welcome_email

  def welcome_email
    BarbarMailer.confirmation_activation_mail(self.email).deliver_now
  end

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes
  end
  
end
