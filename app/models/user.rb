class User < ActiveRecord::Base
  rolify
  # admin, visitor, queen, owner
  # 
  validates :email, presence: true
  validates :name, presence: true
  validates :email, uniqueness: true

  has_one :profile
  has_secure_password
  has_many :products
  mount_uploader :avatar, AvatarUploader

  has_many :queen_product_relations

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
