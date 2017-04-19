class ProfilesController < InheritedResources::Base

	def new
		@user = User.find(params[:user_id])
		@profile = @user.build_profile
	end

	def edit
		@user = User.find(params[:user_id])
		@profile = @user.profile
	end

	def create
		@profile = Profile.new(profile_params)
    @profile.user_id = session[:user_id]
    @user = User.find(session[:user_id])
    respond_to do |format|
      if @profile.save
      	@user.remove_role @user.roles.last.name if @user.roles.last
      	@user.add_role session[:role]

      	@user.state = '等待审核'
      	@user.save(validate: false)
        format.html { redirect_to choose_user_path(@user), notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
	end

  def update

  	@user = User.find(params[:user_id])
  	@profile = @user.profile
    respond_to do |format|
      if @profile.update(profile_params)
      	@user.remove_role @user.roles.last.name
      	@user.add_role session[:role]
      	@user.state = '等待审核'
      	@user.save(validate: false)
        format.html { redirect_to choose_user_path(@user), notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    user = User.find(params[:user_id])
    @profile = user.profile
  end
  private

    def profile_params
      params.require(:profile).permit(:phone, :company, :qq, :wechat, :verify_img1, :verify_img2, :verify_img3, :address, :other, :state)
    end
end
