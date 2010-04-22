# TODO

# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_oreidig_session',
  :secret      => 'b4c3184b9a99dd37b2e80171b4117d003e265115b46f1329adcb413f8d49c4484e3cf676b7bf47e06448b0106fb7078909781ebb75c9b636a7ddd16b617a013c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
