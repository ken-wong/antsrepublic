class User < ActiveRecord::Base
  rolify
  # admin, visitor, queen, owner
  # 
  validates :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :name, presence: false
  validates :email, uniqueness: true
  validates :password, length: { in: 6..20 }

  has_one :profile
  has_secure_password
  has_many :products
  mount_uploader :avatar, AvatarUploader


  acts_as_follower
  acts_as_voter
  acts_as_messageable  :required => :body

  state_machine :state, :initial => :'未认证' do
    event :confirm! do
      transition [nil, :'未认证', :'拒绝', :'等待审核'] => :'认证通过'
    end

    event :unconfirm! do
      transition [nil, :'认证通过',:'未认证', :'等待审核'] => :'拒绝'
    end
  end
end
