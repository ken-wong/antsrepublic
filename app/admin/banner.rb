ActiveAdmin.register Banner do
  permit_params :title, :image, :state

  qiniu_deal = (Rails.env.test? || Rails.env.development?) ? "" : '&imageView2/2/w/200/h/200'

  form do |f|
    f.input :title
    f.inputs I18n.t('activerecord.attributes.banner.image'), :multipart => true do
      f.input :image, as: :file, hint: (image_tag(f.object.image.url + qiniu_deal) if !f.object.new_record?)
      f.input :image_cache, as: :hidden 
    end
    f.input :state, collection: ["active", "inactive"]
    f.actions
  end

  show do
    attributes_table do
      row :title
      row I18n.t('activerecord.attributes.banner.image') do
        image_tag banner.image.url + qiniu_deal
      end

      row :state
    end
  end
end