class SearchesController < ApplicationController
  def create
    links = Link.search params[:q]
    tags = Tag.search params[:q]
    render :json => { :result => { :tags => tags, :links => links } }
  end
end

# curl -v -X POST -H "Accept: application/json" \
# -H "Content-Type: application/json" -d '{"q": "test"}' \
# http://localhost:3000/search
