json.banners do
  json.partial! 'api/banners/banner', collection: @banners, as: :banner
end