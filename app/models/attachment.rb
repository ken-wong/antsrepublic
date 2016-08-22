class Attachment < ActiveRecord::Base
	belongs_to :attachmentable, polymorphic: true
	mount_uploader :file, MediaUploader

	 include Rails.application.routes.url_helpers

	 def to_jq_upload
	    {
	      "name" => read_attribute(:avatar),
	      "size" => avatar.size,
	      "url" => avatar.url,
	      "thumbnail_url" => avatar.small_url
	    }
	 end
end
