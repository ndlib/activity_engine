module ActivityEngine
  class Engine < ::Rails::Engine
    isolate_namespace ActivityEngine

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
    end

    extend ActiveSupport::Autoload
    eager_autoload do
      autoload :ContextBuilder
      autoload :ActivityBuilder
      autoload :ActivityDataStructure
      autoload :Activity
    end
  end
end
