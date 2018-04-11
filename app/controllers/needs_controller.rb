class NeedsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :set_tags

  def new
    redirect_to user_path(current_user) , notice: '只有甲方才可以发布需求' unless current_user.has_role? :owner
    @need = Need.new
    @need.user_id = params[:user_id]
    @my_fav_products = current_user.all_following
  end


  def edit
    @need = Need.find(params[:id])
    @my_fav_products = current_user.all_following
    @reference_product_ids = @need.reference_product_ids ? @need.reference_product_ids.gsub(/\"/, '').gsub(/\[|\]/, '').gsub(' ', '').split(',').reject { |c| c.empty? } : []
    @reference_queen_ids = @need.reference_queen_ids ? @need.reference_queen_ids.gsub(/\"/, '').gsub(/\[|\]/, '').gsub(' ', '').split(',').reject { |c| c.empty? } : []
    @selectedQueens = User.where(id: @reference_queen_ids)
  end

  def show
    @need = Need.find(params[:id])
  end

  def upload_file
    @need = Need.find(params[:id])
    @comments = @need.comments
  end

  def file_list
    @need = Need.find(params[:id])
    @remark = @need.remark
  end

  def waitfor
    @need = Need.find(params[:id])
    @need.waitfor!

    message_str = "蚁后提交了<a href='#{need_tasks_url(@need)}'>#{@need.title}</a> 的项目计划: #{@need.state}"
    current_user.send_message(@need.user, message_str)

    respond_to do |format|
      format.html { redirect_to need_tasks_path(@need), notice: 'Need was successfully updated.' }
    end
  end

  def complete
    @need = Need.find(params[:id])
    @need.close!

    @need.plans.each do |plan|
      plan.close!
    end

    @need.tasks.each do |task|
      task.confirm!
    end

    message_str = "甲方确认项目<a href=#{need_tasks_url(@need)}>#{@need.title}</a>已经完成了"
    current_user.send_message(@need.user, message_str)
    current_user.send_message(@need.queen, message_str)

    respond_to do |format|
      format.html { redirect_to need_tasks_path(@need), notice: 'Need was successfully updated.' }
    end
  end

  def convert_to_queen_work
    @need = Need.find(params[:id])
    pic = @need.tasks.empty? ? '' : @need.tasks.last.attachments.last
    @queen_work = @need.dup
    @queen_work.avatar = pic
    @queen_work.final!
    @queen_work.save

    respond_to do |format|
      format.html { redirect_to product_list_user_path(current_user), notice: 'queen_work was successfully updated.' }
    end
  end

  def plan_confirm
    @need = Need.find(params[:id])
    @need.plan_confirm!
    message_str = "甲方确认了<a href='#{need_tasks_url(@need)}'>#{@need.title}</a> 的项目计划: #{@need.state}"
    current_user.send_message(@need.queen, message_str)

    respond_to do |format|
      format.html { redirect_to need_tasks_path(@need), notice: 'Need was successfully updated.' }
    end
  end

  def plan_refuse
    @need = Need.find(params[:id])
    @need.plan_refuse!
    message_str = "甲方拒绝并质疑<a href='#{need_tasks_url(@need)}'>#{@need.title}</a> 的项目计划: #{@need.state}"
    current_user.send_message(@need.queen, message_str)
    respond_to do |format|
      format.html { redirect_to need_tasks_path(@need), notice: 'Need was successfully updated.' }
    end
  end

  def update
    @need = Need.find(params[:id])
    @need.reference_queen_ids = params[:need][:reference_queen_ids]
    @need.reference_product_ids = params[:need][:reference_product_ids]
     tags = params[:tags]
     tags = [] if tags.nil?

    respond_to do |format|
      @need.tag_list.each do |tag|
        @need.tag_list.remove(tag)
      end

      tags.each do |tag|
        @need.tag_list.add(tag)
      end
      @need.save
      @need.redo!

      if @need.update(need_params)
        format.html { redirect_to need_path(@need), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @need }
      else
        format.html { render :edit }
        format.json { render json: @need.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @need = Need.new(need_params)
    @need.user_id = current_user.id
    @need.reference_queen_ids = params[:need][:reference_queen_ids]
    @need.reference_product_ids = params[:need][:reference_product_ids]
    tags = params[:tags]
    tags = [] if tags.nil?

    respond_to do |format|
      if @need.save
        tags.each do |tag|
          @need.tag_list.add(tag)
        end
        @need.save

        format.html { redirect_to waitfor_upload_need_path(@need), notice: 'Product was successfully updated.'  }
        format.json { render :show, status: :created, location: @need }
      else
        format.html { render :new }
        format.json { render json: @need.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_comment
    @need = Need.find(params[:id])
    comment = @need.comments.create(comment_params)
    comment.user_id = current_user.id
    comment.save
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Comment was successfully added.' }
    end
  end

  def destroy_comment
    @need = Need.find(params[:id])
    comment = Comment.find(params[:comment_id]).destroy
    respond_to do |format|
      format.html { redirect_to need_tasks_path(@need), notice: 'Comment was successfully delete.' }
    end
  end

  def update_comment
    @need = Need.find(params[:id])
    comment = Comment.find(params[:comment_id])
    comment.update(need_params)
    respond_to do |format|
      format.html { redirect_to need_tasks_path(@need), notice: 'Comment was successfully updated.' }
    end
  end

  private
  def set_tags
    @tags = YAML::load(File.read(Rails.root.to_s + '/config/project_tags.yml'))
  end

  def need_params
      params.require(:need).permit(:title, :avatar,
        :client_name, :ref_price, :category, :main_media,
        :description, :user_id, :start_date,
        :ending_date, :final_date, :price_range, :material_name, :remark, :need_img)
  end

  def comment_params
    params.require(:comment).permit(:title, :comment)
  end
end
