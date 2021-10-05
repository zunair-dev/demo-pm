class UserMailer < ApplicationMailer
  default from: 'notifications@xprolabs.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site - Project Management powered by Xprolabs!')
  end
end
