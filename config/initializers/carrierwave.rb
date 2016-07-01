::CarrierWave.configure do |config|
  config.storage             = :qiniu
  config.qiniu_access_key    = "93vlzlK9UlO6UhZaVlrZ4RyVanIv5f1meAX_ofK2"
  config.qiniu_secret_key    = "7UGe9arh_jrxTQGa1WLba3D8xDZ-FbXOJSVYAJt7"
  config.qiniu_bucket        = "ants"
  config.qiniu_bucket_domain = "o9ctas8fi.bkt.clouddn.com"
  config.qiniu_bucket_private= false #default is false
  config.qiniu_block_size    = 4*1024*1024
  config.qiniu_protocal      = "http"

end
