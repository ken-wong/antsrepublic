class Message < ActiveRecord::Base
  after_create :send_mail

  def receiver
    id = self.received_messageable_id
    User.find(id) if id.present?
  end

  def send_mail
    Rails.logger.info '========================Notifier.send_notification============================='
  end
end
