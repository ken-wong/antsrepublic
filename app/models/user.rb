class User < ActiveRecord::Base
  rolify
  validates :email, presence: true
  validates :email, uniqueness: true
  has_secure_password
  has_many :products
  mount_uploader :avatar, AvatarUploader

  acts_as_follower

   state_machine :state, :initial => nil do
    event :confirm do
      transition nil => :'已认证'
    end
  end
end
