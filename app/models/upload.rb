class Upload < ActiveRecord::Base
	belongs_to :product
	validates :media, presence: true
	mount_uploader :media, MainMediaUploader
end
