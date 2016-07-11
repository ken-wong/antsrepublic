ActiveAdmin.register Product do

	permit_params :title, :client_name, :ref_price, :category, :description, :avatar, :main_media

	qiniu_deal = '&imageView2/2/w/200/h/200'

	form do |f|
		f.semantic_errors
		f.input :title
		f.inputs I18n.t('activerecord.attributes.product.avatar'), :multipart => true do
			f.input :avatar, as: :file, hint: (image_tag(f.object.avatar.url + qiniu_deal) if !f.object.new_record?)
			f.input :avatar_cache, as: :hidden 
		end
		f.inputs I18n.t('activerecord.attributes.product.main_media'), :multipart => true do
			f.input :main_media, as: :file, hint: image_tag(f.object.main_media.url)
			f.input :main_media_cache, as: :hidden 
		end
		
		f.input :client_name
		f.input :ref_price
		f.input :category
		f.input	:description

		f.actions
	end

	show do
		attributes_table do
			row :title
			row I18n.t('activerecord.attributes.product.avatar') do
				image_tag product.avatar.url + qiniu_deal
			end

			row :main_media
			row :client_name
			row :ref_price
			row :category
			row	:description
		end
	end
end
