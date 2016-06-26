json.array!(@products) do |product|
  json.extract! product, :id, :title, :avatar, :client_name, :ref_price, :category_id, :main_media, :description
  json.url product_url(product, format: :json)
end
