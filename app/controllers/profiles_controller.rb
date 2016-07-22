class ProfilesController < InheritedResources::Base

	def new
		@user = User.find(params[:user_id])
		@profile = @user.profile
	end

	def edit
		@user = User.find(params[:user_id])
		@profile = @user.profile
	end

	def create
		@profile = Profile.new(profile_params)
    @profile.user_id = session[:user_id]

    respond_to do |format|
      if @profile.save
        format.html { redirect_to user_profile_path(user_id: session[:user_id]), notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
	end

  def update
  	@profile = Profile.find(params[:profile_id])
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end
  private

    def profile_params
      params.require(:profile).permit(:phone, :company, :qq, :wechat, :verify_img1, :verify_img2, :verify_img3, :address, :other)
    end
end

