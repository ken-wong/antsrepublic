class Profile < ActiveRecord::Base
	belongs_to :user
	validates :phone, presence: true

	mount_uploader :verify_img1, AvatarUploader
	mount_uploader :verify_img2, AvatarUploader
	mount_uploader :verify_img3, AvatarUploader
end
