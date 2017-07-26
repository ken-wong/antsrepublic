Rails.application.config.middleware.use OmniAuth::Builder do
  provider :wechat, 'wxb58cdd0b15dc84fb', '94d3336c2b7154b1d0e43bf4bed2d499'
end
