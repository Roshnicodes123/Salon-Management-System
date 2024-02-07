class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def confirmation_login_mail(user)
  
    
    # @url  = 'http://example.com/login'
    mail(to: user, subject: 'Welcome to My Email Site',from: "shuklaroshni2327@gmail.com")
  end
end
