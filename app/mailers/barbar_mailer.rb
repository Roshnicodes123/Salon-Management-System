class BarbarMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def confirmation_activation_mail(barbar)
    # @url  = 'http://example.com/login'
    mail(to: barbar, subject: 'Welcome to My Awesome Site',from: "shuklaroshni2327@gmail.com")
  end

  def account_activation_mail(barbar)
    mail(to: barbar, subject: 'Welcome to My active admin Site',from: "shuklaroshni2327@gmail.com")
  end
end
