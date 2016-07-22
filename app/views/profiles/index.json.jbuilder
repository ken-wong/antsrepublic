json.array!(@profiles) do |profile|
  json.extract! profile, :id, :phone, :company, :qq, :wechat, :verify_img1, :verify_img2, :verify_img3, :address, :other
  json.url profile_url(profile, format: :json)
end
