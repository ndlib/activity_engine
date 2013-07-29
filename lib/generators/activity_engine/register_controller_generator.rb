module ActivityEngine
  module Generators
    class RegisterControllerGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a ActivityEngine initializer."
      argument :class_name, type: :string
      argument :method_name, type: :string

      def copy_initializer
        generate('activity_engine:install')
        text = [
          %(ActivityEngine.for_models('#{class_name}') do |builder|),
          %(  builder.register_controller('#{class_name.pluralize}Controller', '#{method_name}')),
          %(end),
          "",
          ""
        ].join("\n")
        prepend_file('config/post_initializers/activity_engine_config.rb', text)
      end
    end
  end
end
