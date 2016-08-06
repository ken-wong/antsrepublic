ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
 permit_params do
   permitted = [:permitted, :attributes, :email, :name, :cell, :password_digest, :avatar, :state, :description]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
   permitted
 end

 sidebar "profile Details", only: [:show] do
    ul do
      li link_to "认证资料",    admin_profile_path(user.profile) unless user.profile.nil?
    end
  end

	index do
	  column :email
	  column :name
	  column :cell
	  column :avatar
	  column '申请角色' do |user|
	  	I18n.t(user.roles.last.name) unless (user.roles.blank? or user.roles.last.nil?)
	  end
	  column :state
	  column "认证资料" do |user|
	  	link_to "认证资料", admin_profile_path(user.profile) unless user.profile.nil?
	  end
	  actions defaults: false do |user|
	    
	    link_to "拒绝认证", deny_verify_admin_user_path(user), method: :put
	  end
	  actions defaults: false do |user|
	    
	    link_to "通过认证", allow_verify_admin_user_path(user), method: :put
	    
	  end

	  actions
	end

  member_action :allow_verify, method: :put do
    resource.confirm!
    redirect_to admin_users_path, notice: "passed!"
  end

  member_action :deny_verify, method: :put do
    resource.unconfirm!
    redirect_to admin_users_path, notice: "denied!"
  end

end
