module ActivityEngine
  module Generators
    class RegisterGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a ActivityEngine initializer."
      argument :class_name, type: :string
      argument :method_name, type: :string
      argument :subject_method, type: :string

      def copy_initializer
        generate('activity_engine:install')
        text = [
          "ActivityEngine.register('#{class_name}', '#{method_name}') do |activity, context|",
          "  activity.subject = context.#{subject_method}",
          "  activity.current_user = context.current_user",
          "  activity.activity_type = '#{class_name}##{method_name}'",
          "#  activity.message = 'Specify a custom message if applicable'",
          "end",
          "",
          ""
        ].join("\n")

        inject_into_file('config/initializers/activity_engine_config.rb', text, before: /\A.*ActivityEngine.register/)
      end
    end
  end
end
