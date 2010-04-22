class ApplicationController < ActionController::Base
  protect_from_forgery

  # TODO: Perhaps needed later on
  # filter_parameter_logging :password, :password_confirmation
end
