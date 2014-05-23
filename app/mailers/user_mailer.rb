class UserMailer < ActionMailer::Base
  default from: 'account_confirmation@pushbc.com'
 
  def confirmation_email(user)
    @user = user
    mail(to: @user.email, subject: 'Please Confirm Your PushBC Account')
  end
end