# Be sure to restart your server when you modify this file.

# Using old hash style to be able to test with Ruby 1.8.7
Main::Application.config.session_store :cookie_store, :key => '_main_session'
#Main::Application.config.session_store :cookie_store, key: '_main_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Main::Application.config.session_store :active_record_store
