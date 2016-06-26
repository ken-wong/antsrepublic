class Product < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
	mount_uploader :main_media, MainImgUploader
end
