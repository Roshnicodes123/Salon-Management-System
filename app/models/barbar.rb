class Barbar < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  after_create :welcome_email

  def welcome_email
    BarbarMailer.confirmation_login_mail(self.email).deliver_now
  end
end
