class ServiceController < ApplicationController
  before_filter :ensure_json_request
  
  private
  
  def ensure_json_request
    unless request.format == :json
      redirect_to root_url
    end
  end
end
