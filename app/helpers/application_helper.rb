module ApplicationHelper
  # https://gist.github.com/ifightcrime/9291167a0a4367bb55a2
   def active_class(link_path)
    current_page?(link_path) ? "active" : ""
   end

  def parse_image_data(base64_image)
    filename = DateTime.now.to_s(:number)
    in_content_type, encoding, string = base64_image.split(/[:;,]/)[1..3]
  
    @tempfile = Tempfile.new(filename)
    @tempfile.binmode
    @tempfile.write Base64.decode64(string)
    @tempfile.rewind
  
    # for security we want the actual content type, not just what was passed in
    content_type = `file --mime -b #{@tempfile.path}`.split(";")[0]
  
    # we will also add the extension ourselves based on the above
    # if it's not gif/jpeg/png, it will fail the validation in the upload model
    extension = content_type.match(/gif|jpeg|png/).to_s
    filename += ".#{extension}" if extension
  
    ActionDispatch::Http::UploadedFile.new({
      tempfile: @tempfile,
      content_type: content_type,
      filename: filename
    })
  end
  
  def clean_tempfile
    if @tempfile
      @tempfile.close
      @tempfile.unlink
    end
  end

  def queen_log_in(queen)
    session[:queen_id] = queen.id
    @current_queen = queen
  end

  def current_queen
    @current_queen || Queen.find_by(id: session[:queen_id])
  end

  def queen_logged_in?
    !current_queen.nil?
  end

  def queen_logout
    session.delete(:queen_id)
    @current_queen = nil
  end

  def log_in(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def current_user
    @current_user || User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end
