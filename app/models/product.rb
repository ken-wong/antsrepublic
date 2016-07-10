class Product < ActiveRecord::Base
  belongs_to :queen
  belongs_to :category
	mount_uploader :avatar, AvatarUploader
	mount_uploader :main_media, MainMediaUploader

	has_many :uploads

  acts_as_taggable
end
