RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.frameworks -= [ :active_resource, :action_mailer ]
  config.time_zone = 'UTC'

  ##############################################################################
  # TODO: Stuff not yet needed
  # config.load_paths += %W( #{RAILS_ROOT}/extras )
  # config.active_record.observers = :cacher, :garbage_collector,
  #                                  :forum_observer
  # config.i18n.default_locale = :de
end
