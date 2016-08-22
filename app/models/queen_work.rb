class QueenWork < Product
 default_scope { where state: '我的案例'}
 belongs_to :queen
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
