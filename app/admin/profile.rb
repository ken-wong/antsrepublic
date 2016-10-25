ActiveAdmin.register Profile do
	menu false
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

	show do
		attributes_table do
			row :user
			row :id
			row :phone
      row :qq
      row :wechat
      row  :company
      row  :address
      row I18n.t('activerecord.attributes.profile.verify_img1') do
				image_tag profile.verify_img1.url if profile.verify_img1.url
			end
			row I18n.t('activerecord.attributes.profile.verify_img2') do
				image_tag profile.verify_img2.url if profile.verify_img2.url
			end
			row I18n.t('activerecord.attributes.profile.verify_img3') do
				image_tag profile.verify_img3.url if profile.verify_img3.url
			end
      row  :other
		end
	end
end
