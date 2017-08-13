# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class Notifier < ApplicationMailer
  def send_notification(user)
    # http://localhost:3000/rails/mailers/notifier/send_notification
    @user = user
    mail :to => user.email, :subject => "蚂蚁共和消息通知"
  end
end
