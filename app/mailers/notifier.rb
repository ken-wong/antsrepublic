class Notifier < ApplicationMailer
  def send_notification(user)
    @user = user
    mail :to => user.email, :subject => "User Notification"
  end
end
