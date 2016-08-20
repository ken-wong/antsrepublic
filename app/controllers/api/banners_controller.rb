class Api::BannersController < Api::BaseController

  def index
    @banners = Banner.all
  end

end