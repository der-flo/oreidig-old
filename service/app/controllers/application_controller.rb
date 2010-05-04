class ApplicationController < ActionController::Base
  protect_from_forgery

  # TODO prio 2: Perhaps needed later
  # filter_parameter_logging :password, :password_confirmation
end
