class Barbar < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :salon

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
      
  enum status: {inactive: 0, active: 1}

  after_create :confirmation_email

  before_save :send_activation_email, if: :account_activated?
  before_save :send_inactivation_email, if: :account_inactivated?


  def confirmation_email
    BarbarMailer.confirmation_email(self.email).deliver_now
  end

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes
  end

  def send_activation_email
    BarbarMailer.account_activation_mail(email).deliver_now
  end

  def send_inactivation_email
    BarbarMailer.account_inactivation_mail(email).deliver_now
  end
  # private

  def account_activated?  
    status_changed?(from: :inactive, to: :active)
  end


  def account_inactivated?  
    status_changed?(from: :active, to: :inactive)
  end


end
