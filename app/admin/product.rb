ActiveAdmin.register Product do

	permit_params :title, :client_name, :ref_price, :category, :description, :avatar, :main_media

end
