class Queen < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true
  has_secure_password
  mount_uploader :avatar, AvatarUploader
end
