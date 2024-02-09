class BarbarMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def confirmation_email(barbar)
    # @url  = 'http://example.com/login'
    mail(to: barbar, subject: 'Regarding Confirmation Email',from: "shuklaroshni2327@gmail.com")
  end

  def account_activation_mail(barbar)
    mail(to: barbar, subject: 'Regarding Account activation',from: "shuklaroshni2327@gmail.com")
  end

  def account_inactivation_mail(barbar)
    mail(to: barbar, subject: 'Regarding Account Inactivation',from: "shuklaroshni2327@gmail.com")
  end
end
