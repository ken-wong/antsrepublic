class Product < ActiveRecord::Base
  belongs_to :queen
  belongs_to :user
	mount_uploader :avatar, AvatarUploader
	mount_uploader :main_media, MainMediaUploader

	has_many :uploads

  acts_as_taggable
  acts_as_follower
  acts_as_votable
end
