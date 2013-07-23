module ActivityEngine
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a ActivityEngine initializer."

      def copy_initializer
        template "activity_engine_config.rb", "config/initializers/activity_engine_config.rb"
      end

      def run_migrations
        rake('activity_engine:install:migrations')
        rake('db:migrate')
      end

    end
  end
end
