class ApplicationController < ActionController::Base
  protect_from_forgery

  # TODO prio 2: Perhaps needed later
  # filter_parameter_logging :password, :password_confirmation
  
  protected
  
  def rescue_action_in_public exception
    @status_code = response_code_for_rescue(exception)
    @status = interpret_status(@status_code)

    # TODO: All relevant templates
    # not_found, conflict, unprocessable_entity, method_not_allowed,
    # not_implemented, internal_server_error
    respond_to do |format|
      format.html { render :template => "errors/default",
                           #"errors/#{@status[0,3]}",
                           :status => @status }
      # TODO: More information
      format.json { render :json => 'error', :status => @status }
      format.all  { head @status }
    end
  end
  # def local_request?
  #   false
  # end
end
