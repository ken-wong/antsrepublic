class User < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true
  has_secure_password
  has_many :products
  mount_uploader :avatar, AvatarUploader

  acts_as_follower
end
