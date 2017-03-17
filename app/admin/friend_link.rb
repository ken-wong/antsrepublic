ActiveAdmin.register FriendLink do
	permit_params :banner, :title, :linkage

	qiniu_deal = (Rails.env.test? || Rails.env.development?) ? "" : '?imageView2/2/w/200/h/200'
	index do
		column :id
	  column :title
	  column :linkage
	  column :banner do |friend_link|
	  	image_tag friend_link.banner.small_url, size: '128x128'
	  end
		actions
	end

	form do |f|
		f.inputs 'FriendLink' do
    	f.input :title
    	f.input :linkage
  	end
    f.inputs I18n.t('activerecord.attributes.friend_link.banner'), :multipart => true do
      f.input :banner, as: :file, hint: (image_tag(f.object.banner.url + qiniu_deal, size: '200x200') if !f.object.new_record?)
      f.input :banner_cache, as: :hidden 
    end
    
    f.actions
  end
end