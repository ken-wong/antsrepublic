# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.2'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
# 
Rails.application.config.assets.precompile += %w( neat/neat-blue.css )

Rails.application.config.assets.precompile += %w( welcome.js task_fuc.js edit_need_fuc.js queen_works.js queen_work_show.js queen_show.js)

Rails.application.config.assets.precompile += %w( owlcarousel/owl.carousel.min.js owlcarousel/owl.carousel.min.css owlcarousel/owl.theme.default.min.css owlcarousel/owl.theme.green.min.css)
Rails.application.config.assets.precompile += %w( jquery_slider.js)
Rails.application.config.assets.precompile += %w( jquery.scrollUp.min.js)
