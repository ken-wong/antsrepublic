class Queen < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true

  has_many :products
  has_secure_password
  mount_uploader :avatar, AvatarUploader

  acts_as_followable
end
