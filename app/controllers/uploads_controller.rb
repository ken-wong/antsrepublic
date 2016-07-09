class UploadsController < InheritedResources::Base
	def index
		@uploads = Product.find(params[:product_id]).uploads
	end
	
  private

    def upload_params
      params.require(:upload).permit(:media, :product_id)
    end
end

