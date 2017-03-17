class FriendLink < ActiveRecord::Base
	mount_uploader :banner, BannerUploader
end
