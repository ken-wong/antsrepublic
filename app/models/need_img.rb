class NeedImg < ActiveRecord::Base
  belongs_to :need
	mount_uploader :photo, NeedImageUploader
end
