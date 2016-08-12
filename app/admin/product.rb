ActiveAdmin.register Product do

	permit_params :title, :client_name, :ref_price, :category, :description, :avatar, 
	:main_media, :avatar_cache, :main_media_cache, :tag_list, :state, :user_id, :queen_id

	qiniu_deal = (Rails.env.test? || Rails.env.development?) ? "" : '?imageView2/2/w/200/h/200'

	form do |f|
		f.semantic_errors
		
		f.inputs I18n.t('activerecord.attributes.product.avatar'), :multipart => true do
			f.input :avatar, as: :file, hint: (image_tag(f.object.avatar.url + qiniu_deal) if !f.object.new_record? and !f.object.avatar.url.nil?)
			f.input :avatar_cache, as: :hidden 
		end
		f.inputs 'more' do
			f.input :title
			f.input :client_name
			f.input :ref_price
			f.input :category, as: :select, collection: [['效果图','效果图'],["影片","影片"],["多媒体","多媒体"]]
			f.input	:description
			f.input :tag_list, hint: '请使用小写的逗号分割不同标签', input_html:  {value: f.object.tag_list.to_s}
			f.input :queen_id, as: :select, collection: User.with_role(:queen).map{|u| ["#{u.name}|#{u.email}", u.id]}
			f.input :state, collection: ['等待审核', '审核拒绝', '寻找蚁后', '项目开始', '项目终止', '项目完成', '我的案例'] 
		end
		f.actions
	end

	index do
		selectable_column
	  column :title
	  column :client_name
	  column :category
	  column :state
	  actions
	end

	show do
		attributes_table do
			row :title
			row I18n.t('activerecord.attributes.product.avatar') do
				image_tag product.avatar.url + qiniu_deal unless product.avatar.url.nil?
			end

			row :main_media
			row :client_name
			row :ref_price
			row :category
			row	:description
			row :tag_list
			row :reference_product_ids
			row :reference_queen_ids
			row '蚁后' do 
				link_to product.queen.name, admin_user_path(product.queen) if product.queen
			end
			row :state
		end
	end

	member_action :confirm, method: :get do
	  if resource.confirm!
		  resource.send_message(current_admin_user, "等待审核", "寻找蚁后")
		end
	  redirect_to resource_path, notice: "Confirm!"
	end

	member_action :unconfirm, method: :get do
	  if resource.unconfirm!
		  resource.send_message(current_admin_user, "等待审核", "审核拒绝")
		end
	  redirect_to resource_path, notice: "Not allow!"
	end

	action_item only: :show do
	  link_to t(:confirm), confirm_admin_product_path(product)
	end

	action_item only: :show do
	  link_to t(:unconfirm), unconfirm_admin_product_path(product)
	end

	after_update do |product|
		
		if product.queen
			message_str = "项目:<a href='#{need_path(product)}'>#{product.title}</a>, 已经指派给<a href='#{queen_path(product.queen_id)}'>#{product.queen.name}</a> "
			current_admin_user.send_message(product.queen, message_str) 
			current_admin_user.send_message(product.user, message_str)
		else
			message_str = "管理员更改了项目:<a href='#{need_path(product)}'>#{product.title}</a> 的状态: #{product.state}" 
			current_admin_user.send_message(product.user, message_str)
		end

	end
end
