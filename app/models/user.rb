class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable
        #  validates :username, presence: true, uniqueness:(case_insensitive: false)
  after_create :welcome_email
  has_many :appointments
  belongs_to :salon, optional: true 
  has_one :time_slot 
  def welcome_email
    UserMailer.confirmation_login_mail(self.email).deliver_now
  end
        
end
