# Preview all emails at http://localhost:3000/rails/mailers/notifier
class NotifierPreview < ActionMailer::Preview
  def send_notification
    Notifier.send_notification(User.last, Message.first.body)
  end
end
