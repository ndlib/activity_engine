module ActivityEngine
  module Generators
    class RegisterGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a ActivityEngine initializer."
      argument :class_name, type: :string
      argument :method_name, type: :string

      def copy_initializer
        generate('activity_engine:install')
        text = [
          "ActivityEngine.register_models('#{class_name}')",
          "ActivityEngine.register_controller('#{class_name.pluralize}Controller', '#{method_name}')",
          "",
          ""
        ].join("\n")

        inject_into_file('config/post_initializers/activity_engine_config.rb', text, before: /\A.*ActivityEngine.register/)
      end
    end
  end
end
