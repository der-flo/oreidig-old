class AssociatedController < ApplicationController
  def show
    tag = Tag.find_by_name!(params[:tag_id])
    render :json => tag.associated_as_json
  end
end
