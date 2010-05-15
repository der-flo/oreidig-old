class TagsController < ServiceController
  before_filter :load_tag, :only => [:show, :update]
  skip_before_filter :verify_authenticity_token
  
  def index
    @tags = Tag.all
    render :json => @tags
  end
  def show
    render :json => @tag
  end

  def update
    if @tag.update_attributes params[:tag]
      head :ok
    else
      render :json => @tag.errors, :status => :unprocessable_entity
    end
  end

  # TODO: Other ops

  private
  def load_tag
    @tag = Tag.find_by_name!(params[:id])
  end
end
