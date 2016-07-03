class Product < ActiveRecord::Base
  belongs_to :queen
	mount_uploader :avatar, AvatarUploader
	mount_uploader :main_media, MainMediaUploader
end
