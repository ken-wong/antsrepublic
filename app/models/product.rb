class Product < ActiveRecord::Base
  belongs_to :queen
  belongs_to :user
	mount_uploader :avatar, AvatarUploader
	mount_uploader :main_media, MainMediaUploader

	has_many :uploads

  acts_as_taggable
  acts_as_follower
  acts_as_votable

  # :state, collection: ['等待审核', '审核拒绝', '指派蚁后', '项目开始', '项目终止', '项目完成'] 
end
