class Message < ActiveRecord::Base
  def receiver
    id = self.received_messageable_id
    User.find(id) if id.present?
  end
end
