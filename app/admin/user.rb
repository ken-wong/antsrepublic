ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
 permit_params do
   permitted = [
   		:permitted, :attributes,
   		:email, :name, :cell, :password_digest,
   		:avatar, :state, :description, :sort_no
   	]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
   permitted
 end

 # sidebar "profile Details", only: [:show] do
 #    ul do
 #      li link_to "认证资料",    admin_profile_path(user.profile) unless user.profile.nil?
 #    end
 #  end

	index do
		column :id
	  column :email
	  column :name
	  column :cell
	  column :avatar do |user|
	  	image_tag user.avatar.small_url, size: '128x128'
	  end
	  column '申请角色' do |user|
	  	I18n.t(user.roles.last.name) unless (user.roles.blank? or user.roles.last.nil?)
	  end
	  column :state
	  column "认证资料" do |user|
	  	link_to "认证资料", admin_profile_path(user.profile) unless user.profile.nil?
	  end

	  actions defaults: false do |user|
	  	link_to("拒绝 ", deny_verify_admin_user_path(user), method: :put) +
	    link_to(" 通过", allow_verify_admin_user_path(user), method: :put) +
	    link_to(" 删除", admin_user_path(user), method: :delete)
	  end
	end


	show do
		attributes_table do
			row :id
			row :email
			row :name
			row :cell
      row :company
      row I18n.t('activerecord.attributes.user.avatar') do
				image_tag user.avatar.url if user.avatar.url
			end
      row :state
      row :description
      row :created_at
		end
	end

  member_action :allow_verify, method: :put do
    user = User.find(params[:id])
    user.update_attribute(:state, '认证通过')
  	message_str = "管理员已经设置用户: <a href='#{user_path(resource)}'>#{resource.name}</a> 状态为 #{resource.state}  "
		current_admin_user.send_message(resource, message_str)
    redirect_to admin_users_path
  end

  member_action :deny_verify, method: :put do
    user = User.find(params[:id])
    user.update_attribute(:state, '认证拒绝')
    message_str = "管理员已经设置用户: <a href='#{user_path(resource)}'>#{resource.name}</a> 状态为 #{resource.state}  "
		current_admin_user.send_message(resource, message_str)
    redirect_to admin_users_path
  end

end
