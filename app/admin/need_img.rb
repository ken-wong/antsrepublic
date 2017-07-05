ActiveAdmin.register NeedImg do
  menu priority: 3

  belongs_to :need

  index title: '资料列表' do
    column '资料类型' do |need|
      need.photo.file.extension
    end
    column '资料名称' do |need|
      need.photo.filename
    end
    column '下载' do |need|
      link_to '下载', image_path("#{need.photo.url}"), :target => "_blank"
    end
  end
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


end
