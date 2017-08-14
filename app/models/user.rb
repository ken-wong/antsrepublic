class User < ActiveRecord::Base
  rolify
  # admin, visitor, queen, owner
  # 
  validates :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :name, presence: false
  validates :email, uniqueness: true
  validates :password, length: { in: 6..20 }

  attr_accessor :reset_token

  has_one :profile
  has_secure_password
  has_many :products
  mount_uploader :avatar, AvatarUploader
  has_many :complains
  has_many :messages

  acts_as_follower
  acts_as_voter
  acts_as_messageable  :required => :body, class_name: "Message"
  acts_as_paranoid

  state_machine :state, :initial => :'未认证' do
    event :confirm! do
      transition [nil, :'未认证', :'认证拒绝', :'等待审核'] => :'认证通过'
    end

    event :unconfirm! do
      transition [nil, :'认证通过',:'未认证', :'等待审核'] => :'认证拒绝'
    end
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(password_reset_token: User.digest(reset_token), password_reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver
  end

  def send_password_reset
    # generate_token(:password_reset_token)
    self.reset_token = User.new_token
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  class << self
    def digest(string)
      Digest::MD5.hexdigest(string)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
