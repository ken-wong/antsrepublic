class Task < ActiveRecord::Base
  belongs_to :need
  belongs_to :plan

  validates :title, presence: true
  validates :plan_id, presence: true
  mount_uploader :media, MainMediaUploader
end
