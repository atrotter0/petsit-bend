module PaginateHelper
  def paginate_settings(limit)
    return :page => params[:page], per_page: limit
  end
end