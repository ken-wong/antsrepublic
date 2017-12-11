class Message < ActsAsMessageable::Message
  after_create :send_mail

  def receiver
    id = self.received_messageable_id
    User.find(id) if id.present?
  end

  def send_mail
    begin
      Notifier.send_notification(self.receiver, self.body).deliver_now
    rescue Exception
    end
  end
end
