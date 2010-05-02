class TagsController < ServiceController
  before_filter :load_tag, :only => :show
  
  def index
    @tags = Tag.all
    render :json => @tags
  end
  def show
    render :json => @tag
  end

  # TODO: Other ops

  private
  def load_tag
    @tag = Tag.find_by_name!(params[:id])
  end
end
