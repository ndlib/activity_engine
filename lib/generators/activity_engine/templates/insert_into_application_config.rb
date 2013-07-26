
    # So your models and controllers are all properly initialized, make sure
    # that ActivityEngine loads after all of the initializers (i.e. files in
    # "./config/initializers")
    config.after_initialize do
      require 'activity_engine'
      require File.expand_path('../post_initializers/activity_engine_config.rb', __FILE__)
    end
