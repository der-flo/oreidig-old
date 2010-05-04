RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.frameworks -= [ :active_resource, :action_mailer ]
  config.time_zone = 'UTC'

  config.gem 'shoulda', :version => '2.10.3'
  config.gem 'factory_girl', :version => '1.2.4'
  config.gem 'faker', :version => '0.3.1'
  config.gem 'crack'
end
