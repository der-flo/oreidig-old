class LinksController < ServiceController
  before_filter :load_link, :only => [:show, :update, :destroy]
  def index
    tags = (params[:tags] || '').split(',')
    @links = if tags.empty?
      Link.all
    else
      tags = tags.map {|tag| tag.strip }
      Link.find_all_by_tags tags
    end
    render :json => @links.to_json
  end
  def show
    @link = Link.find(params[:id])
    render :json => @link
  end
  def create
    @link = Link.new params[:link]
    if @link.save
      render :json => @link, :status => :created, :location => @link
    else
      render :json => @link.errors, :status => :unprocessable_entity
    end
  end
  def update
    if @link.update_attributes params[:link]
      head :ok
    else
      render :json => @link.errors, :status => :unprocessable_entity
    end
  end
  def destroy
    @link.destroy
    head :ok
  end
  private
  def load_link
    @link = Link.find(params[:id])
  end
end

# curl -v -X DELETE http://localhost:3000/links/1

# curl -v -X POST -H "Accept: application/json" \
# -H "Content-Type: application/json" -d "{"link": {"url": "bla"}}" \
# http://localhost:3000/links

# curl -v -X PUT -H "Accept: application/json" \
# -H "Content-Type: application/json" -d "{"link": {"notes": "test"}}" \
# http://localhost:3000/links/1
