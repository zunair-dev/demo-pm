class UserMailer < ApplicationMailer
  default from: 'notifications@xprolabs.com'

  def welcome_email
    @user = params[:user]
    @url  = root_url
    mail(to: @user.email, subject: 'Welcome to My Awesome Site - Project Management powered by Xprolabs!')
  end

  def send_credentials
    @user = params[:user]
    @password = params[:password]
    @url  = root_url
    mail(to: @user.email, subject: "Your credentials")
  end

  def send_task_alert
    @user = params[:user]
    @task = params[:task]
    @url  = employees_tasks_url
    mail(to: @user.email, subject: "New Task Assigned")
  end
end
