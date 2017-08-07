class Message < ActiveRecord::Base
  after_save :sent_notification

  def sent_notification
    Rails.logger.info '==================================mail======================='
  end
end
