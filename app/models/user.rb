class User < ActiveRecord::Base
  rolify
  # admin, visitor, queen, owner
  # 
  validates :email, presence: true
  validates :email, uniqueness: true
  has_secure_password
  has_many :products
  mount_uploader :avatar, AvatarUploader

  acts_as_follower
  acts_as_voter

  state_machine :state, :initial => :'未认证' do
    event :confirm do
      transition :'未认证' => :'已认证'
    end
  end
end
