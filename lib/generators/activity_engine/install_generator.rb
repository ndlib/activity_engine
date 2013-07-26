module ActivityEngine
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a ActivityEngine initializer."

      def copy_initializer
        template "activity_engine_config.rb", "config/post_initializers/activity_engine_config.rb"
      end

      def insert_into_application_config
        application do
          File.read(File.join(self.class.source_root, "insert_into_application_config.rb"))
        end
      end

      def install_migrations
        rake('activity_engine:install:migrations')
      end

    end
  end
end
