module Satchel
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a Satchel initializer."

      def copy_initializer
        template "satchel_config.rb", "config/initializers/satchel_config.rb"
      end

    end
  end
end
