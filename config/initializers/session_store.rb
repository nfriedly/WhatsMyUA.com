# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_whatsmyua.com_session',
  :secret      => 'bdef0f54de17601cfca54381a6c126ea3a0bb5844f9abab977f8cba3480fba745f014770d7f948c7061a45fbc80fe433384b30acd26cb8d68d7237f86bb5628a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
