class Message < ActsAsMessageable::Message
  after_create :send_mail

  def receiver
    id = self.received_messageable_id
    User.find(id) if id.present?
  end

  def send_mail
    Notifier.send_notification(self.receiver).deliver_now
  end
end
