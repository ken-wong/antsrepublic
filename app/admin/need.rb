ActiveAdmin.register Need do
	menu priority: 2
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
			f.input :state, collection: ['等待审核', '审核拒绝', '寻找蚁后', '提交计划', '等待甲方', '乙方执行','项目终止', '项目完成', '我的案例'] 
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
			row I18n.t('activerecord.attributes.need.avatar') do
				image_tag need.avatar.url + qiniu_deal unless need.avatar.url.nil?
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
				link_to need.queen.name, admin_user_path(need.queen) if need.queen
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
	  link_to t(:confirm), confirm_admin_need_path(need)
	end

	action_item only: :show do
	  link_to t(:unconfirm), unconfirm_admin_need_path(need)
	end

	after_update do |need|
		
		if need.queen
			message_str = "<strong>项目<a href='#{need_path(need)}'>#{need.title}</a>, 已经指派给蚁后:<a href='#{queen_path(need.queen_id)}'>#{need.queen.name}</a> </strong>"
			current_admin_user.send_message(need.queen, message_str) 
			current_admin_user.send_message(need.user, message_str)
		else
			message_str = "管理员更改了项目:<a href='#{need_path(need)}'>#{need.title}</a> 的状态: #{need.state}" 
			current_admin_user.send_message(need.user, message_str)
		end

	end
end
