if Rails.env == "development"
  Rails.configuration.gem 'uki', :version => '1.1.1'
  Rails.configuration.middleware.insert_before "ActionController::Failsafe",
                                              "UkiDevMiddleware"
end