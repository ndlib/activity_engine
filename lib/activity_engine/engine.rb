module ActivityEngine
  class Engine < ::Rails::Engine
    isolate_namespace ActivityEngine

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
    end


    initializer "activity_engine.initialize", after: :load_config_initializers do
      require 'activity_engine/activity_sweeper'
    end
  end
end
